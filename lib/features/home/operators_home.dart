import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/data/models/user.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/features/schedule/widgets/operator_task_card.dart';
import 'package:tiberium_crm/features/utils/widgets/empty_tasks_list.dart';
import 'package:tiberium_crm/features/utils/widgets/task_info_row.dart';
import 'package:tiberium_crm/features/utils/widgets/update_task_button.dart';
import 'package:tiberium_crm/repos/repository.dart';

class OperatorsHome extends StatefulWidget {
  final Role role;
  const OperatorsHome(this.role, {super.key});

  @override
  State<OperatorsHome> createState() => _OperatorsHomeState();
}

class _OperatorsHomeState extends State<OperatorsHome>
    with AutoRouteAwareStateMixin {
  final rep = GetIt.I.get<Repository>();

  AutoRouteObserver? _routeObserver;

  String? destination;
  int? priority;
  String? status;
  User? operator;
  User? manager;
  double? amount;
  String? uid;

  @override
  void initState() {
    _getTaskDetails();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeObserver =
        RouterScope.of(context).firstObserverOfType<AutoRouteObserver>();
    if (_routeObserver != null) {
      _routeObserver!.subscribe(this, context.routeData);
    }
  }

  @override
  void didChangeTabRoute(TabPageRoute previousRoute) => _getTaskDetails();

  @override
  Widget build(BuildContext context) => destination != null
      ? Column(
          children: [
            OperatorTaskCard(
              destination: destination ?? 'Unknown',
              priority: priority ?? 3,
              status: status ?? 'Unknown',
              operator: operator,
              targetKilos: amount ?? 0,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TaskInfoRow('Task ID', uid ?? 'Unknown'),
                  const SizedBox(height: 16),
                  TaskInfoRow(
                    'Manager',
                    manager != null
                        ? '${manager?.firstName} ${manager?.lastName}'
                        : 'Not assigned',
                  ),
                ],
              ),
            ),
            UpdateTaskButton(
              status: status!,
              callback: () => _updateTaskStatus(
                context,
                status == 'TO_DO' ? 'IN_PROGRESS' : 'DONE',
              ),
            ),
          ],
        )
      : const EmptyTasksList();

  Future<void> _updateTaskStatus(BuildContext context, String status) async {
    final statusBody = '{"status": "$status"}';
    try {
      final res = widget.role == Role.harvestOperator
          ? (await rep.patchHarvestTasks(uid!, statusBody)).data.uid
          : (await rep.patchProcessingTasks(uid!, statusBody)).data.uid;
      _getTaskDetails();
      if ((res?.isNotEmpty ?? false) && mounted) {
        AutoRouter.of(context).replaceAll([const ScheduleRoute()]);
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

  Future<void> _getTaskDetails() async {
    if (widget.role == Role.harvestOperator) {
      final tasks = (await rep.getHarvestTasks())
          .harvestTasks
          ?.where((task) => task.status != 'DONE');

      if (tasks?.isNotEmpty ?? false) {
        final lastTask = tasks!.last;
        destination = lastTask.destination;
        operator = lastTask.harvestOperator;
        priority = lastTask.priority;
        status = lastTask.status;
        manager = lastTask.harvestManager;
        uid = lastTask.uid;
        amount = lastTask.targetKilosToHarvest;
      }
    } else {
      final tasks = (await rep.getProcessingTasks())
          .processingTasks
          ?.where((task) => task.status != 'DONE');

      if (tasks?.isNotEmpty ?? false) {
        final lastTask = tasks!.last;
        destination = lastTask.destination;
        operator = lastTask.processingOperator;
        priority = lastTask.priority;
        status = lastTask.status;
        manager = lastTask.processingManager;
        uid = lastTask.uid;
        amount = lastTask.processedKilos;
      }
    }
    if (mounted) setState(() {});
  }
}
