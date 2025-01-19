import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';

class TaskEntry extends StatefulWidget {
  final HarvestTask task;
  final VoidCallback onTaskUpdated;

  const TaskEntry({
    required this.task,
    super.key,
    required this.onTaskUpdated,
  });

  @override
  State<TaskEntry> createState() => _TaskEntryState();
}

class _TaskEntryState extends State<TaskEntry> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await AutoRouter.of(context).push(
          TaskRoute(task: widget.task),
        );
        if (result == true) {
          widget.onTaskUpdated();
        }
      },
      child: Column(children: [
        const Divider(color: Colors.black87),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(flex: 1, child: Text(widget.task.priority.toString())),
              Expanded(
                flex: 2,
                child: Text(widget.task.destination ?? 'Unknown'),
              ),
              Expanded(
                flex: 2,
                child: Text('${widget.task.harvestOperator?.firstName} '
                    '${widget.task.harvestOperator?.lastName}'),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.black87),
      ]),
    );
  }
}
