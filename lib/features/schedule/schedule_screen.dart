import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/features/schedule/widgets/main_task_entry.dart';
import 'package:tiberium_crm/features/schedule/widgets/harvest_task_entry.dart';
import 'package:tiberium_crm/features/schedule/widgets/processing_task_entry.dart';
import 'package:tiberium_crm/features/utils/widgets/empty_tasks_list.dart';
import 'package:tiberium_crm/repos/repository.dart';

@RoutePage()
class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late final Role currRole;

  final SharedPreferences localStorage = GetIt.I.get();
  final rep = GetIt.I.get<Repository>();

  List<HarvestTaskEntry> harvestTasks = [];
  List<ProcessingTaskEntry> procTasks = [];
  List<MainTaskEntry> mainTasks = [];

  @override
  void initState() {
    currRole = _getCurrRole();
    _getTasks();
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
                'Schedule',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ),
        body: _isTasksListsEmpty()
            ? const EmptyTasksList()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ...harvestTasks,
                    ...procTasks,
                    ...mainTasks,
                  ],
                ),
              ),
      );

  bool _isTasksListsEmpty() =>
      mainTasks.isEmpty && procTasks.isEmpty && harvestTasks.isEmpty;

  Future<void> _getTasks() async {
    if (currRole == Role.harvestOperator) {
      _getHarvestTasks();
    } else if (currRole == Role.processingOperator) {
      _getProcessingTasks();
    } else {
      _getMainTasks();
    }
  }

  Future<void> _getMainTasks() async {
    final list = await rep.getMainTasks();

    if (mounted) {
      mainTasks.clear();
      setState(
        () => mainTasks.addAll(
          list.data.map(
            (hTask) => MainTaskEntry(
              task: hTask,
              onTaskUpdated: _getTasks,
            ),
          ),
        ),
      );
    }
  }

  Future<void> _getHarvestTasks() async {
    final list = await rep.getHarvestTasks();

    if (mounted) {
      harvestTasks.clear();
      setState(
        () => harvestTasks.addAll(
          list.harvestTasks?.map(
                (hTask) => HarvestTaskEntry(
                  task: hTask,
                  onTaskUpdated: _getHarvestTasks,
                ),
              ) ??
              [],
        ),
      );
    }
  }

  Future<void> _getProcessingTasks() async {
    final list = await rep.getProcessingTasks();

    if (mounted) {
      procTasks.clear();
      setState(
        () => procTasks.addAll(
          list.processingTasks?.map(
                (pTask) => ProcessingTaskEntry(
                  task: pTask,
                  onTaskUpdated: _getProcessingTasks,
                ),
              ) ??
              [],
        ),
      );
    }
  }

  Role _getCurrRole() =>
      RoleExtension.fromString(localStorage.getString('role')!);
}
