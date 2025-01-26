import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/features/schedule/widgets/main_task_entry.dart';
import 'package:tiberium_crm/features/schedule/widgets/task_entry.dart';
import 'package:tiberium_crm/repos/repository.dart';

import 'widgets/processing_task_entry.dart';

@RoutePage()
class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late final Role currRole;
  final SharedPreferences localStorage = GetIt.I.get();
  final rep = GetIt.I.get<Repository>();
  List<HarvestTaskEntry>? harvestTasks = [];
  List<ProcessingTaskEntry>? procTasks = [];
  List<MainTaskEntry>? mainTasks = [];

  @override
  void initState() {
    currRole = _getCurrRole();
    _getTasks();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Tasks',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: FractionalOffset.topLeft,
                  padding: const EdgeInsets.all(12),
                  child: const Text('Assigned tasks:'),
                ),
                for (HarvestTaskEntry task in harvestTasks ?? []) task,
                for (ProcessingTaskEntry task in procTasks ?? []) task,
                for (MainTaskEntry task in mainTasks ?? []) task,
                const Padding(padding: EdgeInsets.all(30)),
              ],
            ),
          ),
          if (!_isOperator())
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () => _navigateToNewTaskPage(context),
                child: const Text(
                  'New',
                  style: TextStyle(color: Colors.black87, fontSize: 32),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _getTasks() async {
    if (_isOperator()) {
      currRole == Role.harvestOperator
          ? _getHarvestTasks()
          : _getProcessingTasks();
    } else {
      _getMainTasks();
    }
  }

  Future<void> _getHarvestTasks() async {
    final list = await rep.getHarvestTasks();

    final items = list.harvestTasks
        ?.map(
          (hTask) => HarvestTaskEntry(
            task: hTask,
            onTaskUpdated: _getHarvestTasks,
          ),
        )
        .toList();
    if (mounted) {
      setState(() => harvestTasks = items);
    }
  }

  bool _isOperator() =>
      currRole == Role.harvestOperator || currRole == Role.processingOperator;

  Future<void> _getMainTasks() async {
    if (_isOperator()) return;

    final list = await rep.getMainTasks();

    final items = list.data
        .map(
          (hTask) => MainTaskEntry(
            task: hTask,
            onTaskUpdated: _getHarvestTasks,
          ),
        )
        .toList();
    if (mounted) {
      setState(() => mainTasks = items);
    }
  }

  Future<void> _getProcessingTasks() async {
    final list = await rep.getProcessingTasks();

    final items = list.processingTasks?.map((pTask) {
      return ProcessingTaskEntry(
        task: pTask,
        onTaskUpdated: _getProcessingTasks,
      );
    }).toList();
    if (mounted) {
      setState(() {
        procTasks = items;
      });
    }
  }

  Future<void> _navigateToNewTaskPage(BuildContext context) async {
    bool result;
    if (currRole == Role.salesManager) {
      result = await AutoRouter.of(context).push(const NewPlanRoute()) as bool;
    } else {
      result = await AutoRouter.of(context)
          .push(NewTaskRoute(currRole: currRole)) as bool;
    }

    if (result == true) {
      if (currRole == Role.harvestManager) {
        await _getHarvestTasks();
      } else if (currRole == Role.processingManager) {
        await _getProcessingTasks();
      } else {
        await _getMainTasks();
      }
    }
  }

  Role _getCurrRole() =>
      RoleExtension.fromString(localStorage.getString('role')!);
}
