import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/features/schedule/widgets/main_task_entry.dart';
import 'package:tiberium_crm/features/utils/widgets/empty_tasks_list.dart';
import 'package:tiberium_crm/repos/repository.dart';

class ManagerSchedule extends StatefulWidget {
  final Role currRole;
  const ManagerSchedule(this.currRole, {super.key});

  @override
  State<ManagerSchedule> createState() => _ManagerScheduleState();
}

class _ManagerScheduleState extends State<ManagerSchedule> {
  final rep = GetIt.I.get<Repository>();
  List<MainTaskEntry> tasks = [];

  @override
  void initState() {
    _getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      tasks.isNotEmpty ? Column(children: tasks) : const EmptyTasksList();

  Future<void> _getTasks() async {
    final list = await rep.getMainTasks();

    final items = list.data
        .map(
          (hTask) => MainTaskEntry(
            task: hTask,
            onTaskUpdated: _getTasks,
          ),
        )
        .toList();
    if (mounted) {
      setState(() => tasks = items);
    }
  }
}
