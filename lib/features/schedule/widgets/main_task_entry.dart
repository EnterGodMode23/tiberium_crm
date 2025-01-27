import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tiberium_crm/data/models/tasks/main_task.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/features/schedule/widgets/manager_task_card.dart';

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
          widget.onTaskUpdated();
        }
      },
      child: ManagerTaskCard(
        destination: widget.task.destination,
        targetKilos: widget.task.targetKilosToSale,
        priority: widget.task.priority,
        manager: widget.task.salesManager,
        managerTitle: 'Sales Manager',
      ),
    );
  }
}
