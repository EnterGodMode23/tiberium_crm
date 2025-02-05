import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task_list.dart';
import 'package:tiberium_crm/data/models/tasks/processing_task_list.dart';
import 'package:tiberium_crm/data/models/tasks/main_task_response.dart';
import 'package:tiberium_crm/features/home/home_screen.dart';
import 'package:tiberium_crm/features/home/managers_home.dart';
import 'package:tiberium_crm/features/home/operators_home.dart';
import 'package:tiberium_crm/features/home/sales_home.dart';
import 'package:tiberium_crm/repos/repository.dart';
import '../../helpers/test_utils.dart';

void main() {
  late Repository mockRepo;
  late SharedPreferences mockPrefs;

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
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('HomePage', () {
    testWidgets('shows operator view when user is operator',
        (WidgetTester tester) async {
      // Arrange
      when(mockPrefs.getString('role'))
          .thenReturn(Role.harvestOperator.toStringX());

      // Act
      await tester.pumpTheWidget(const HomePage());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(OperatorsHome), findsOneWidget);
      expect(find.byType(ManagersHome), findsNothing);
      expect(find.byType(SalesHome), findsNothing);
    });

    testWidgets('shows manager view when user is manager',
        (WidgetTester tester) async {
      // Arrange
      when(mockPrefs.getString('role'))
          .thenReturn(Role.harvestManager.toStringX());

      // Act
      await tester.pumpTheWidget(const HomePage());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ManagersHome), findsOneWidget);
      expect(find.byType(OperatorsHome), findsNothing);
      expect(find.byType(SalesHome), findsNothing);
    });

    testWidgets('shows sales view when user is sales manager',
        (WidgetTester tester) async {
      // Arrange
      when(mockPrefs.getString('role'))
          .thenReturn(Role.salesManager.toStringX());

      // Act
      await tester.pumpTheWidget(const HomePage());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(SalesHome), findsOneWidget);
      expect(find.byType(OperatorsHome), findsNothing);
      expect(find.byType(ManagersHome), findsNothing);
    });
  });
}
