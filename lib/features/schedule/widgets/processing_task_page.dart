import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/tasks/processing_task.dart';
import 'package:tiberium_crm/features/schedule/widgets/operator_task_card.dart';
import 'package:tiberium_crm/features/utils/widgets/update_task_button.dart';
import 'package:tiberium_crm/repos/repository.dart';

@RoutePage()
class ProcessingTaskPage extends StatefulWidget {
  final ProcessingTask task;

  const ProcessingTaskPage({
    required this.task,
    super.key,
  });

  @override
  State<ProcessingTaskPage> createState() => _ProcessingTaskPageState();
}

class _ProcessingTaskPageState extends State<ProcessingTaskPage> {
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
                status: widget.task.status ?? 'Unknown',
                operator: widget.task.processingOperator,
                targetKilos: widget.task.processedKilos?.toDouble() ?? 0,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoRow('Task ID', widget.task.uid ?? 'Unknown'),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      'Processing Manager',
                      '${widget.task.processingManager?.firstName ?? 'Unknown name'} ${widget.task.processingManager?.lastName ?? 'Unknown lastname'}',
                    ),
                  ],
                ),
              ),
              if ((currRole == 'HARVEST_OPERATOR' ||
                  currRole == 'PROCESSING_OPERATOR'))
                UpdateTaskButton(
                  status: widget.task.status!,
                  callback: () => _updateTaskStatus(
                    context,
                    widget.task.status == 'TO_DO' ? 'IN_PROGRESS' : 'DONE',
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

  Future<void> _updateTaskStatus(BuildContext context, String status) async {
    try {
      final res = await rep.patchProcessingTasks(
        widget.task.uid ?? '',
        '{"status": "$status"}',
      );
      if (res.data.uid?.isNotEmpty ?? false) {
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
