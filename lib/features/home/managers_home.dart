import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/features/schedule/widgets/processing_task_entry.dart';
import 'package:tiberium_crm/features/schedule/widgets/task_entry.dart';
import 'package:tiberium_crm/features/utils/widgets/empty_tasks_list.dart';
import 'package:tiberium_crm/repos/repository.dart';

class ManagersHome extends StatefulWidget {
  final Role role;
  const ManagersHome(this.role, {super.key});

  @override
  State<ManagersHome> createState() => _ManagersHomeState();
}

class _ManagersHomeState extends State<ManagersHome> {
  final rep = GetIt.I.get<Repository>();
  List<Widget> tasks = [];

  @override
  void initState() {
    _getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          tasks.isNotEmpty
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(children: tasks),
                )
              : const EmptyTasksList(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () => _newTask(context),
                child: const Text(
                  'New',
                  style: TextStyle(color: Colors.black87, fontSize: 32),
                ),
              ),
            ),
          ),
        ],
      );

  Future<void> _newTask(BuildContext context) async {
    try {
      await AutoRouter.of(context).push(NewTaskRoute(currRole: widget.role));
      _getTasks();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update tasks: $e')),
        );
      }
    }
  }

  Future<void> _getTasks() async => widget.role == Role.harvestManager
      ? _getHarvestTasks()
      : _getProcessingTasks();

  Future<void> _getHarvestTasks() async {
    final list = await rep.getHarvestTasks();

    if (mounted) {
      tasks.clear();

      setState(
        () => tasks.addAll(
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
      tasks.clear();
      setState(
        () => tasks.addAll(
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
}
