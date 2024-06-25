import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tiberium_crm/app.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/features/schedule/widgets/task_entry.dart';
import '../../data/models/teststuff.dart' as t;
import '../../data/models/task.dart';

@RoutePage()
class SchedulePage extends StatelessWidget {
  final List<Task> tasks = t.tasks;

  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {

    final currRole = App.localStorage.getString('role') ?? '';
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
        body: Stack(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: FractionalOffset.topLeft,
                  padding: const EdgeInsets.all(12),
                  child: const Text('Assigned tasks:'),
                ),
                for (Task task in tasks)
                  TaskEntry(
                    task: task,
                  ),
                const Padding(padding: EdgeInsets.all(30)),
              ],
            ),
          ),
          if (currRole == 'HARVEST_MANAGER' ||
              currRole == 'PROCESSING_MANAGER')
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
        ]));
  }
}
