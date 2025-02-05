import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/create_new_main_task_req.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/data/models/tasks/main_task.dart';
import 'package:tiberium_crm/data/models/tasks/single_main_task_response.dart';
import 'package:tiberium_crm/data/models/user.dart';
import 'package:tiberium_crm/data/models/users_list.dart';
import 'package:tiberium_crm/features/schedule/widgets/new_plan_page.dart';
import 'package:tiberium_crm/repos/repository.dart';
import '../../../helpers/test_utils.dart';

void main() {
  late Repository mockRepo;
  late SharedPreferences mockPrefs;

  final mockUser = User(
    uid: 'test-uid',
    firstName: 'Test',
    lastName: 'User',
    role: Role.harvestManager,
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

  final harvestManager = User(
    uid: 'test-uid',
    firstName: 'Test',
    lastName: 'User',
    role: Role.harvestManager,
    phoneNumber: '+1234567890',
  );

  final processingManager = User(
    uid: 'test-uid-2',
    firstName: 'Test',
    lastName: 'User2',
    role: Role.processingManager,
    phoneNumber: '+1234567890',
  );

  final testMainTaskReq = CreateNewMainTaskReq(
    processingManagerId: processingManager.uid,
    harvestManagerId: harvestManager.uid,
    targetKilosToSale: 100.0,
    destination: 'Test Destination',
    priority: 1,
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
    when(mockPrefs.getString('role')).thenReturn(Role.salesManager.toStringX());
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('NewPlanPage', () {
    testWidgets('shows all form fields', (WidgetTester tester) async {
      // Act
      await tester.pumpTheWidget(const NewPlanPage());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('New Plan'), findsOneWidget);
      expect(find.text('Mining curator'), findsOneWidget);
      expect(find.text('Processing curator'), findsOneWidget);
      expect(find.text('Tiberium amount'), findsOneWidget);
      expect(find.text('Destination'), findsOneWidget);
      expect(find.text('Priority'), findsOneWidget);
      expect(find.text('Create plan'), findsOneWidget);
    });

    testWidgets('shows validation errors when form is empty',
        (WidgetTester tester) async {
      // Act
      await tester.pumpTheWidget(const NewPlanPage());
      await tester.pumpAndSettle();

      // Try to submit empty form
      await tester.tap(find.text('Create plan'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Enter the mining curator'), findsOneWidget);
      expect(find.text('Enter the processing curator'), findsOneWidget);
      expect(find.text('Enter the tiberium amount'), findsOneWidget);
      expect(find.text('Enter the destination'), findsOneWidget);
      expect(find.text('Enter the priority'), findsOneWidget);
    });

    testWidgets('creates plan successfully', (WidgetTester tester) async {
      // Arrange

      when(mockRepo.postMainTask(testMainTaskReq)).thenAnswer(
        (_) async => SingleMainTaskResponse(data: mockMainTask),
      );
      when(mockRepo.getUsers()).thenAnswer(
        (_) async => UsersList(users: [harvestManager, processingManager]),
      );

      // Act
      await tester.pumpTheWidget(const NewPlanPage());
      await tester.pumpAndSettle();

      // Fill form
      // Mining curator
      await tester.tap(find.byKey(const Key('harvest_manager_id')));
      await tester.pumpAndSettle();
      await tester.tap(find
          .text('${harvestManager.firstName}  ${harvestManager.lastName}')
          .first);
      await tester.pumpAndSettle();

      // Processing curator
      await tester.tap(find.byKey(const Key('proc_manager_id')));
      await tester.pumpAndSettle();
      await tester.tap(find
          .text('${processingManager.firstName}  ${processingManager.lastName}')
          .first);
      await tester.pumpAndSettle();

      // Amount
      await tester.enterText(
        find.byKey(const Key('amount')),
        '100',
      );
      await tester.pumpAndSettle();

      // Destination
      await tester.enterText(
        find.byKey(const Key('destination')),
        'Test Destination',
      );
      await tester.pumpAndSettle();

      // Priority
      await tester.tap(find.byKey(const Key('priority')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('1').first);
      await tester.pumpAndSettle();

      // Submit form
      await tester.tap(find.text('Create plan'));
      await tester.pumpAndSettle();

      // Assert
      verify(mockRepo.getUsers()).called(1);
    });

    testWidgets('shows error snackbar when plan creation fails',
        (WidgetTester tester) async {
      // Arrange
      when(mockRepo.getUsers()).thenAnswer(
        (_) async => UsersList(users: [harvestManager, processingManager]),
      );
      when(mockRepo.postMainTask(testMainTaskReq))
          .thenThrow(Exception('Network error'));

      // Act
      await tester.pumpTheWidget(const NewPlanPage());
      await tester.pumpAndSettle();

      // Fill form
      // Mining curator
      await tester.tap(find.byKey(const Key('harvest_manager_id')));
      await tester.pumpAndSettle();
      await tester.tap(find
          .text('${harvestManager.firstName}  ${harvestManager.lastName}')
          .first);
      await tester.pumpAndSettle();

      // Processing curator
      await tester.tap(find.byKey(const Key('proc_manager_id')));
      await tester.pumpAndSettle();
      await tester.tap(find
          .text('${processingManager.firstName}  ${processingManager.lastName}')
          .first);
      await tester.pumpAndSettle();

      // Amount
      await tester.enterText(
        find.byKey(const Key('amount')),
        '100',
      );
      await tester.pumpAndSettle();

      // Destination
      await tester.enterText(
        find.byKey(const Key('destination')),
        'Test Destination',
      );
      await tester.pumpAndSettle();

      // Priority
      await tester.tap(find.byKey(const Key('priority')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('1').first);
      await tester.pumpAndSettle();

      // Submit form
      await tester.tap(find.text('Create plan'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
