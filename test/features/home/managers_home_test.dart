import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task_list.dart';
import 'package:tiberium_crm/data/models/tasks/processing_task_list.dart';
import 'package:tiberium_crm/data/models/user.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task.dart';
import 'package:tiberium_crm/data/models/tasks/processing_task.dart';
import 'package:tiberium_crm/features/home/managers_home.dart';
import 'package:tiberium_crm/features/schedule/widgets/harvest_task_entry.dart';
import 'package:tiberium_crm/features/schedule/widgets/processing_task_entry.dart';
import 'package:tiberium_crm/features/utils/widgets/empty_tasks_list.dart';
import 'package:tiberium_crm/repos/repository.dart';
import '../../helpers/mocks.mocks.dart';
import '../../helpers/test_utils.dart';
import 'package:tiberium_crm/data/models/tasks/main_task_response.dart';

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

  final mockHarvestTask = HarvestTask(
    uid: 'harvest-task-1',
    mainTaskRef: 'main-1',
    targetKilosToHarvest: 100,
    priority: 1,
    destination: 'Test Destination',
    status: 'TO_DO',
    harvestManager: mockUser,
    harvestOperator: mockUser,
  );

  final mockProcessingTask = ProcessingTask(
    uid: 'proc-task-1',
    mainTaskRef: 'main-1',
    processedKilos: 100,
    priority: 1,
    destination: 'Test Destination',
    status: 'TO_DO',
    processingManager: mockUser,
    processingOperator: mockUser,
  );

  setUp(() async {
    await setupTestDependencies();
    mockRepo = GetIt.I<Repository>();
    mockPrefs = GetIt.I<SharedPreferences>();

    // Setup default responses for mocks
    when(mockRepo.getHarvestTasks())
        .thenAnswer((_) async => HarvestTaskList(harvestTasks: []));
    when(mockRepo.getProcessingTasks())
        .thenAnswer((_) async => ProcessingTaskList(processingTasks: []));
    when(mockRepo.getMainTasks())
        .thenAnswer((_) async => MainTaskResponse(data: []));
    
    // Setup SharedPreferences mock
    when(mockPrefs.getString('role')).thenReturn(Role.harvestManager.toStringX());
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('ManagersHome', () {
    testWidgets('shows empty state when no tasks available for harvest manager',
        (WidgetTester tester) async {
      // Arrange
      when(mockRepo.getHarvestTasks())
          .thenAnswer((_) async => HarvestTaskList(harvestTasks: []));

      // Act
      await tester.pumpTheWidget(ManagersHome(Role.harvestManager));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(EmptyTasksList), findsOneWidget);
      expect(find.byType(HarvestTaskEntry), findsNothing);
    });

    testWidgets('shows empty state when no tasks available for processing manager',
        (WidgetTester tester) async {
      // Arrange
      when(mockRepo.getProcessingTasks())
          .thenAnswer((_) async => ProcessingTaskList(processingTasks: []));

      // Act
      await tester.pumpTheWidget(ManagersHome(Role.processingManager));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(EmptyTasksList), findsOneWidget);
      expect(find.byType(ProcessingTaskEntry), findsNothing);
    });

    testWidgets('shows harvest tasks when available',
        (WidgetTester tester) async {
      // Arrange
      when(mockRepo.getHarvestTasks()).thenAnswer(
        (_) async => HarvestTaskList(harvestTasks: [mockHarvestTask]),
      );

      // Act
      await tester.pumpTheWidget(ManagersHome(Role.harvestManager));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(EmptyTasksList), findsNothing);
      expect(find.byType(HarvestTaskEntry), findsOneWidget);
      expect(find.text('Test Destination'), findsOneWidget);
      expect(find.textContaining('100'), findsOneWidget);
    });

    testWidgets('shows processing tasks when available',
        (WidgetTester tester) async {
      // Arrange
      when(mockRepo.getProcessingTasks()).thenAnswer(
        (_) async => ProcessingTaskList(
          processingTasks: [mockProcessingTask],
        ),
      );

      // Act
      await tester.pumpTheWidget(ManagersHome(Role.processingManager));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(EmptyTasksList), findsNothing);
      expect(find.byType(ProcessingTaskEntry), findsOneWidget);
      expect(find.text('Test Destination'), findsOneWidget);
      expect(find.textContaining('100'), findsOneWidget);
    });

    testWidgets('shows new task button', (WidgetTester tester) async {
      // Arrange
      when(mockRepo.getHarvestTasks())
          .thenAnswer((_) async => HarvestTaskList(harvestTasks: []));

      // Act
      await tester.pumpTheWidget(ManagersHome(Role.harvestManager));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('New'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
