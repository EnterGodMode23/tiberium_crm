import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task.dart';
import 'package:tiberium_crm/features/schedule/widgets/operator_task_card.dart';
import 'package:tiberium_crm/repos/repository.dart';

@RoutePage()
class HarvestTaskPage extends StatefulWidget {
  final HarvestTask task;

  const HarvestTaskPage({
    required this.task,
    super.key,
  });

  @override
  State<HarvestTaskPage> createState() => _HarvestTaskPageState();
}

class _HarvestTaskPageState extends State<HarvestTaskPage> {
  late final String currRole;
  final SharedPreferences localStorage = GetIt.I.get();
  final rep = GetIt.I.get<Repository>();

  @override
  void initState() {
    currRole = localStorage.getString('role') ?? '';
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
                'Task Details',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              OperatorTaskCard(
                destination: widget.task.destination ?? 'Unknown',
                priority: widget.task.priority ?? 0,
                status: widget.task.status,
                operator: widget.task.harvestOperator,
                targetKilos: widget.task.targetKilosToHarvest?.toDouble() ?? 0,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoRow('Task ID', widget.task.uid),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      'Harvest Manager',
                      widget.task.harvestManager != null
                          ? '${widget.task.harvestManager?.firstName} ${widget.task.harvestManager?.lastName}'
                          : 'Not assigned',
                    ),
                  ],
                ),
              ),
              if ((currRole == 'HARVEST_OPERATOR' ||
                      currRole == 'PROCESSING_OPERATOR') &&
                  widget.task.status != 'IN_PROGRESS')
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () => _updateTaskStatus(context),
                    child: const Text(
                      'Start Task',
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );

  Widget _buildInfoRow(String label, String value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );

  Future<void> _updateTaskStatus(BuildContext context) async {
    try {
      final res = await rep.patchHarvestTasks(
        widget.task.uid,
        '{"status": "IN_PROGRESS"}',
      );
      if (res.data.uid.isNotEmpty) {
        if (mounted) {
          AutoRouter.of(context).pop(true);
        }
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to update task status: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}
