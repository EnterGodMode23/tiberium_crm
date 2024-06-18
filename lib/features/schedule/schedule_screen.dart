import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:tiberium_crm/features/schedule/widgets/task_entry.dart';
import '../../data/models/teststuff.dart' as t;
// import 'package:tiberium_crm/data/models/person.dart';
// import 'package:tiberium_crm/data/user_role.dart';
import '../../data/models/task.dart';

@RoutePage()
class SchedulePage extends StatelessWidget {
  final List<Task> tasks = t.tasks;
  const SchedulePage({super.key});

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: FractionalOffset.topLeft,
                padding: const EdgeInsets.all(12),
                child: const Text('Assigned tasks:'),
              ),
              for (Task task in tasks)
                TaskEntry( task: task,)
            ],
          ),
        )
    );
  }
}
