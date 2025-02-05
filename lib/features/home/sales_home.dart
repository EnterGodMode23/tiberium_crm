import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/features/schedule/widgets/main_task_entry.dart';
import 'package:tiberium_crm/features/schedule/widgets/processing_task_entry.dart';
import 'package:tiberium_crm/features/schedule/widgets/harvest_task_entry.dart';
import 'package:tiberium_crm/features/utils/widgets/empty_tasks_list.dart';
import 'package:tiberium_crm/repos/repository.dart';

class SalesHome extends StatefulWidget {
  const SalesHome({super.key});

  @override
  State<SalesHome> createState() => _SalesHomeState();
}

class _SalesHomeState extends State<SalesHome> with AutoRouteAwareStateMixin {
  final rep = GetIt.I.get<Repository>();
  List<Widget> mainTasks = [];
  List<Widget> procTasks = [];
  List<Widget> harvTasks = [];

  AutoRouteObserver? _routeObserver;

  @override
  void initState() {
    _getTasks();
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
  void didChangeTabRoute(TabPageRoute previousRoute) => _getTasks();

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          _isTasksListsEmpty()
              ? const EmptyTasksList()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SectionHeader('Main Tasks'),
                      ...mainTasks,
                      const SizedBox(height: 16),
                      if (harvTasks.isNotEmpty)
                        const SectionHeader('Harvest Tasks'),
                      ...harvTasks,
                      const SizedBox(height: 16),
                      if (procTasks.isNotEmpty)
                        const SectionHeader('Processing Tasks'),
                      ...procTasks,
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () => _newPlan(context),
                child: const Text(
                  'New',
                  style: TextStyle(color: Colors.black87, fontSize: 32),
                ),
              ),
            ),
          ),
        ],
      );

  Future<void> _newPlan(BuildContext context) async {
    try {
      await AutoRouter.of(context).push(const NewPlanRoute());
      _getTasks();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update tasks: $e'),
          ),
        );
      }
    }
  }

  bool _isTasksListsEmpty() =>
      mainTasks.isEmpty && procTasks.isEmpty && harvTasks.isEmpty;

  Future<void> _getTasks() async {
    final listMain = await rep.getMainTasks();
    final listHarv = await rep.getHarvestTasks();
    final listProc = await rep.getProcessingTasks();

    mainTasks.clear();
    mainTasks.addAll(
      listMain.data.map(
        (hTask) => MainTaskEntry(
          task: hTask,
          onTaskUpdated: _getTasks,
        ),
      ),
    );

    harvTasks.clear();
    harvTasks.addAll(
      listHarv.harvestTasks?.map(
            (hTask) => HarvestTaskEntry(
              task: hTask,
              onTaskUpdated: _getTasks,
            ),
          ) ??
          [],
    );

    procTasks.clear();
    procTasks.addAll(
      listProc.processingTasks?.map(
            (hTask) => ProcessingTaskEntry(
              task: hTask,
              onTaskUpdated: _getTasks,
            ),
          ) ??
          [],
    );

    if (mounted) setState(() {});
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1, color: Colors.black26),
          ],
        ),
      );
}
