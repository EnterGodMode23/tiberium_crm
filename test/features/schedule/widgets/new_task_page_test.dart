import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task_list.dart';
import 'package:tiberium_crm/data/models/tasks/main_task_response.dart';
import 'package:tiberium_crm/data/models/tasks/single_harvest_task_response.dart';
import 'package:tiberium_crm/data/models/tasks/single_proc_task_response.dart';
import 'package:tiberium_crm/data/models/user.dart';
import 'package:tiberium_crm/data/models/users_list.dart';
import 'package:tiberium_crm/features/schedule/widgets/new_task_page.dart';
import 'package:tiberium_crm/repos/repository.dart';
import '../../../helpers/test_utils.dart';
import 'package:tiberium_crm/data/models/create_new_proc_task_req.dart';
import 'package:tiberium_crm/data/models/create_new_harvest_task_req.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task.dart';
import 'package:tiberium_crm/data/models/tasks/processing_task.dart';
import 'package:tiberium_crm/data/models/tasks/main_task.dart';

void main() {
  late Repository mockRepo;
  late SharedPreferences mockPrefs;

  final mockUser = User(
    uid: 'test-uid',
    firstName: 'Test',
    lastName: 'User',
    role: Role.harvestOperator,
    phoneNumber: '+1234567890',
  );

  final mockMainTask = MainTask(
    uid: 'main-1',
    destination: 'Test Destination',
    status: 'TO_DO',
    salesManager: mockUser,
    harvestManager: mockUser,
    processingManager: mockUser,
    salesManagerId: '123',
    processingManagerId: '423',
    harvestManagerId: '542534',
    targetKilosToSale: 100,
    priority: 1,
  );

  final mockHarvestTask = HarvestTask(
    uid: 'test-uid',
    mainTaskRef: 'main-1',
    targetKilosToHarvest: 100,
    priority: 1,
    destination: 'Test Destination',
    status: 'TO_DO',
    harvestManager: mockUser,
    harvestOperator: mockUser,
  );

  final mockProcessingTask = ProcessingTask(
    uid: 'test-uid',
    mainTaskRef: 'main-1',
    processedKilos: 100,
    priority: 1,
    destination: 'Test Destination',
    status: 'TO_DO',
    processingManager: mockUser,
    processingOperator: mockUser,
  );

  final mockHarvestTaskReq = CreateNewHarvestTaskReq(
    harvestOperator: 'test-uid',
    destination: 'Test Destination',
    priority: 1,
    mainTaskRef: 'main-1',
    killos: 100,
    status: 'TO_DO',
  );

  final mockProcTaskReq = CreateNewProcTaskReq(
    harvestTaskId: 'test-uid',
    processingOperator: 'test-uid',
    destination: 'Test Destination',
    priority: 1,
    mainTaskRef: 'main-1',
    killos: 100,
    status: 'TO_DO',
  );

  setUp(() async {
    await setupTestDependencies();
    mockRepo = GetIt.I<Repository>();
    mockPrefs = GetIt.I<SharedPreferences>();

    // Setup default responses
    when(mockRepo.getUsers()).thenAnswer(
      (_) async => UsersList(users: [mockUser]),
    );
    when(mockRepo.getMainTasks()).thenAnswer(
      (_) async => MainTaskResponse(data: []),
    );
    when(mockRepo.getHarvestTasks())
        .thenAnswer((_) async => HarvestTaskList(harvestTasks: []));
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('NewTaskPage', () {
    testWidgets('shows form fields for harvest manager',
        (WidgetTester tester) async {
      // Arrange
      when(mockPrefs.getString('role'))
          .thenReturn(Role.harvestManager.toStringX());

      // Act
      await tester.pumpTheWidget(NewTaskPage(Role.harvestManager));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('New Task'), findsOneWidget);
      expect(find.text('Operator'), findsOneWidget);
      expect(find.text('Main task'), findsOneWidget);
      expect(find.text('Priority'), findsOneWidget);
      expect(find.text('Tiberium amount'), findsOneWidget);
      expect(find.text('Create task'), findsOneWidget);
    });

    testWidgets('shows form fields for processing manager',
        (WidgetTester tester) async {
      // Arrange
      when(mockPrefs.getString('role'))
          .thenReturn(Role.processingManager.toStringX());

      // Act
      await tester.pumpTheWidget(NewTaskPage(Role.processingManager));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('New Task'), findsOneWidget);
      expect(find.text('Operator'), findsOneWidget);
      expect(find.text('Harvest task'), findsOneWidget);
      expect(find.text('Priority'), findsOneWidget);
      expect(find.text('Tiberium amount'), findsOneWidget);
      expect(find.text('Create task'), findsOneWidget);
    });

    testWidgets('shows validation errors when form is empty',
        (WidgetTester tester) async {
      // Arrange
      when(mockPrefs.getString('role'))
          .thenReturn(Role.harvestManager.toStringX());

      // Act
      await tester.pumpTheWidget(NewTaskPage(Role.harvestManager));
      await tester.pumpAndSettle();

      // Try to submit empty form
      await tester.tap(find.text('Create task'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Enter the task\'s operator'), findsOneWidget);
      expect(find.text('Enter the main task'), findsOneWidget);
      expect(find.text('Enter the priority'), findsOneWidget);
      expect(find.text('Enter the tiberium amount'), findsOneWidget);
    });

    testWidgets('creates harvest task successfully',
        (WidgetTester tester) async {
      // Arrange
      when(mockRepo.postHarvestTask(mockHarvestTaskReq)).thenAnswer(
        (_) async => SingleHarvestTaskResponse(data: mockHarvestTask),
      );
      when(mockRepo.getMainTasks()).thenAnswer(
        (_) async => MainTaskResponse(data: [mockMainTask]),
      );
      when(mockRepo.getUsers()).thenAnswer(
        (_) async => UsersList(users: [mockUser]),
      );

      // Act
      await tester.pumpTheWidget(NewTaskPage(Role.harvestManager));
      await tester.pumpAndSettle();

      // Fill form
      // Оператор
      await tester.tap(find.byKey(const Key('operator')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('${mockUser.firstName}  ${mockUser.lastName}').first);
      await tester.pumpAndSettle();

      // Main task
      await tester.tap(find.text('Main task'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Test Destination').first);
      await tester.pumpAndSettle();

      // Priority
      await tester.tap(find.byKey(const Key('priority')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('1').first);
      await tester.pumpAndSettle();

      // Amount
      await tester.enterText(
        find.byKey(const Key('kilos')),
        '100',
      );
      await tester.pumpAndSettle();

      // Submit form
      await tester.tap(find.text('Create task'));
      await tester.pumpAndSettle();

      // Assert
      verify(mockRepo.getUsers()).called(1);
    });

    testWidgets('creates processing task successfully',
        (WidgetTester tester) async {
      // Arrange
      when(mockPrefs.getString('role'))
          .thenReturn(Role.processingManager.toStringX());
      when(mockRepo.postProcessingTask(mockProcTaskReq)).thenAnswer(
        (_) async => SingleProcessingTaskResponse(data: mockProcessingTask),
      );
      when(mockRepo.getUsers()).thenAnswer(
        (_) async => UsersList(users: [mockUser]),
      );
      when(mockRepo.getHarvestTasks()).thenAnswer(
        (_) async => HarvestTaskList(harvestTasks: [mockHarvestTask]),
      );

      // Act
      await tester.pumpTheWidget(NewTaskPage(Role.processingManager));
      await tester.pumpAndSettle();

      // Fill form
      // Оператор
      await tester.tap(find.byKey(const Key('operator')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('${mockUser.firstName}  ${mockUser.lastName}').first);
      await tester.pumpAndSettle();

      // Harvest task
      await tester.tap(find.text('Harvest task'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Test Destination').first);
      await tester.pumpAndSettle();

      // Priority
      await tester.tap(find.byKey(const Key('priority')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('1').first);
      await tester.pumpAndSettle();

      // Amount
      await tester.enterText(
        find.byKey(const Key('kilos')),
        '100',
      );
      await tester.pumpAndSettle();

      // Submit form
      await tester.tap(find.text('Create task'));
      await tester.pumpAndSettle();

      // Assert
      verify(mockRepo.getUsers()).called(1);
      verify(mockRepo.getHarvestTasks()).called(1);
    });

    testWidgets('shows error snackbar when task creation fails',
        (WidgetTester tester) async {
      // Arrange
      when(mockRepo.getUsers()).thenAnswer(
        (_) async => UsersList(users: [mockUser]),
      );
      when(mockRepo.getMainTasks()).thenAnswer(
        (_) async => MainTaskResponse(data: [mockMainTask]),
      );
      when(mockRepo.postHarvestTask(mockHarvestTaskReq))
          .thenThrow(Exception('Network error'));

      // Act
      await tester.pumpTheWidget(NewTaskPage(Role.harvestManager));
      await tester.pumpAndSettle();

      // Fill form
      // Оператор
      await tester.tap(find.byKey(const Key('operator')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('${mockUser.firstName}  ${mockUser.lastName}').first);
      await tester.pumpAndSettle();

      // Main task
      await tester.tap(find.text('Main task'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Test Destination').first);
      await tester.pumpAndSettle();

      // Priority
      await tester.tap(find.byKey(const Key('priority')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('1').first);
      await tester.pumpAndSettle();

      // Amount
      await tester.enterText(
        find.byKey(const Key('kilos')),
        '100',
      );
      await tester.pumpAndSettle();

      // Submit form
      await tester.tap(find.text('Create task'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
