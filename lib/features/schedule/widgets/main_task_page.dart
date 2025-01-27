import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/tasks/main_task.dart';
import 'package:tiberium_crm/features/schedule/widgets/manager_task_card.dart';
import 'package:tiberium_crm/repos/repository.dart';

@RoutePage()
class MainTaskPage extends StatefulWidget {
  final MainTask task;

  const MainTaskPage({required this.task, super.key});

  @override
  State<MainTaskPage> createState() => _MainTaskPageState();
}

class _MainTaskPageState extends State<MainTaskPage> {
  late final String currRole;
  final SharedPreferences localStorage = GetIt.I.get();
  final rep = GetIt.I.get<Repository>();

  @override
  void initState() {
    currRole = localStorage.getString('role') ?? '';
    super.initState();
  }

  String _getNextStatus() {
    switch (widget.task.status) {
      case 'TO_DO':
        return 'HARVESTING';
      case 'HARVESTING':
        return 'PROCESSING';
      case 'PROCESSING':
        return 'COMPLETED';
      default:
        return widget.task.status ?? 'TO_DO';
    }
  }

  String _getButtonText() {
    switch (widget.task.status) {
      case 'TO_DO':
        return 'Start Harvesting';
      case 'HARVESTING':
        return 'Move to Processing';
      case 'PROCESSING':
        return 'Complete Task';
      default:
        return 'Update Status';
    }
  }

  bool _shouldShowButton() {
    if (currRole == 'HARVEST_MANAGER') {
      return widget.task.status != 'COMPLETED';
    }
    return false;
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
              ManagerTaskCard(
                destination: widget.task.destination,
                targetKilos: widget.task.targetKilosToSale,
                priority: widget.task.priority,
                manager: widget.task.salesManager,
                managerTitle: 'Sales Manager',
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoRow('Status', widget.task.status ?? 'TO_DO'),
                    const SizedBox(height: 16),
                    _buildInfoRow('Task ID', widget.task.uid),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      'Processing Manager',
                      '${widget.task.processingManager.firstName} ${widget.task.processingManager.lastName}',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      'Harvest Manager',
                      '${widget.task.harvestManager.firstName} ${widget.task.harvestManager.lastName}',
                    ),
                  ],
                ),
              ),
              if (_shouldShowButton())
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () => _updateTaskStatus(context),
                    child: Text(
                      _getButtonText(),
                      style: const TextStyle(fontSize: 32),
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
      final nextStatus = _getNextStatus();
      final res = await rep.patchMainTasks(
        widget.task.uid,
        '{"status": "$nextStatus"}',
      );

      if (res.data.uid.isNotEmpty) {
        if (mounted) {
          await rep.getMainTasks();
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
