import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/features/schedule/widgets/task_entry.dart';
import 'package:tiberium_crm/repos/repository.dart';

@RoutePage()
class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late final String currRole;
  final SharedPreferences localStorage = GetIt.I.get();
  List<TaskEntry>? harvestTasks = [];

  @override
  void initState() {
    currRole = localStorage.getString('role') ?? '';
    _getHarvestTasks();
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
                for (TaskEntry task in harvestTasks ?? [])
                  task,
                // for (Task task in tasks)
                //   TaskEntry(
                //     task: task,
                //   ),
                const Padding(padding: EdgeInsets.all(30)),
              ],
            ),
          ),
          if (currRole == 'HARVEST_MANAGER' || currRole == 'PROCESSING_MANAGER')
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () {
                  AutoRouter.of(context).navigate(const NewTaskRoute());
                },
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
  Future<void> _getHarvestTasks() async {
    final rep = GetIt.I.get<Repository>();
    final list = await rep.getHarvestTasks();

    final items = list.harvestTasks?.map((hTask) {
      return TaskEntry(task: hTask);
    }).toList();
    if (mounted) {
      setState(() {
        harvestTasks = items;
      });
    }
  }
}
