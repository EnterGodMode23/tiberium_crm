import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import '../../../data/models/task.dart';

class TaskEntry extends StatefulWidget {
  final Task task;

  const TaskEntry({
    required this.task,
    super.key,
  });

  @override
  State<TaskEntry> createState() => _TaskEntryState();
}

class _TaskEntryState extends State<TaskEntry> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AutoRouter.of(context).navigate(TaskRoute(task: widget.task));
      },
      child: Column(children: [
        const Divider(color: Colors.black87),
        Row(
          children: [
            Expanded(flex: 1, child: Text(widget.task.priority.toString())),
            Expanded(flex: 2, child: Text(widget.task.destination)),
            Expanded(flex: 2, child: Text(widget.task.operator.fio)),
          ],
        ),
        const Divider(color: Colors.black87),
      ]),
    );
  }
}
