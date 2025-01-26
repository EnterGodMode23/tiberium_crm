import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tiberium_crm/data/models/tasks/main_task.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';

class MainTaskEntry extends StatefulWidget {
  final MainTask task;
  final VoidCallback onTaskUpdated;

  const MainTaskEntry({
    required this.task,
    super.key,
    required this.onTaskUpdated,
  });

  @override
  State<MainTaskEntry> createState() => _MainTaskEntryState();
}

class _MainTaskEntryState extends State<MainTaskEntry> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await AutoRouter.of(context).push(
          MainTaskRoute(task: widget.task),
        );
        if (result == true) {
          widget.onTaskUpdated(); // Call the callback function
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
                  flex: 2, child: Text(widget.task.destination ?? 'Unknown')),
              Expanded(
                flex: 2,
                child: Text('{widget.task.processingOperator?.firstName} '
                    '{widget.task.processingOperator?.lastName}'),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.black87),
      ]),
    );
  }
}
