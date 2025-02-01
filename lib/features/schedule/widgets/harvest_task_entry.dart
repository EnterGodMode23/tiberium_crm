import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/features/schedule/widgets/task_details_card.dart';
import 'package:tiberium_crm/features/schedule/widgets/operator_task_card.dart';

class HarvestTaskEntry extends StatefulWidget {
  final HarvestTask task;
  final VoidCallback onTaskUpdated;

  const HarvestTaskEntry({
    required this.task,
    super.key,
    required this.onTaskUpdated,
  });

  @override
  State<HarvestTaskEntry> createState() => _HarvestTaskEntryState();
}

class _HarvestTaskEntryState extends State<HarvestTaskEntry> {
  final SharedPreferences localStorage = GetIt.I.get();

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () async {
          final result = await AutoRouter.of(context).push(
            HarvestTaskRoute(task: widget.task),
          );
          if (result == true) {
            widget.onTaskUpdated();
          }
        },
        child: Column(
          children: [
            if (_isOperator())
              TaskDetailsCard(
                destination: widget.task.destination ?? 'Unknown',
                priority: widget.task.priority ?? 0,
                status: widget.task.status,
              )
            else
              OperatorTaskCard(
                destination: widget.task.destination ?? 'Unknown',
                priority: widget.task.priority ?? 0,
                status: widget.task.status,
                operator: widget.task.harvestOperator,
                targetKilos: widget.task.targetKilosToHarvest?.toDouble() ?? 0,
              ),
          ],
        ),
      );

  bool _isOperator() {
    final role = localStorage.getString('role');
    return role == 'HARVEST_OPERATOR' || role == 'PROCESSING_OPERATOR';
  }
}
