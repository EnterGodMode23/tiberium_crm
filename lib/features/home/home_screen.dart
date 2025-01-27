import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/features/home/operators_home.dart';
import 'package:tiberium_crm/features/home/sales_home.dart';
import 'package:tiberium_crm/features/home/managers_home.dart';
import 'package:tiberium_crm/features/schedule/widgets/main_task_entry.dart';
import 'package:tiberium_crm/features/schedule/widgets/task_entry.dart';
import 'package:tiberium_crm/features/schedule/widgets/processing_task_entry.dart';
import 'package:tiberium_crm/repos/repository.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Role currRole;
  final SharedPreferences localStorage = GetIt.I.get();
  final rep = GetIt.I.get<Repository>();
  List<MainTaskEntry>? mainTasks = [];

  List<HarvestTaskEntry>? harvestTasks = [];
  List<ProcessingTaskEntry>? procTasks = [];

  @override
  void initState() {
    currRole = _getCurrRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Home',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ),
        body: _isOperator()
            ? OperatorsHome(currRole)
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: currRole == Role.salesManager
                    ? const SalesHome()
                    : ManagersHome(currRole),
              ),
      );

  bool _isOperator() =>
      currRole == Role.harvestOperator || currRole == Role.processingOperator;

  Future<void> _navigateToNewTaskPage(BuildContext context) async {
    bool? result;
    try {
      if (currRole == Role.salesManager) {
        result =
            await AutoRouter.of(context).push(const NewPlanRoute()) as bool?;
      } else {
        result = await AutoRouter.of(context)
            .push(NewTaskRoute(currRole: currRole)) as bool?;
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update tasks: $e'),
          ),
        );
      }
    }
  }

  Role _getCurrRole() =>
      RoleExtension.fromString(localStorage.getString('role')!);
}
