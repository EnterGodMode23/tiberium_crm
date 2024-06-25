import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/app.dart';
import '../../../data/models/task.dart';

@RoutePage()
class TaskPage extends StatefulWidget {
  final Task task;

  const TaskPage({
    required this.task,
    super.key,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late final String currRole;
  final SharedPreferences localStorage = GetIt.I.get();

  @override
  void initState() {
    currRole = localStorage.getString('role') ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Task Info',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: FractionalOffset.center,
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Text(
                      'Task ID:',
                    ),
                    Text(
                      widget.task.id,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Type:',
                    ),
                  ),
                  Expanded(flex: 1, child: Text(widget.task.type.name)),
                ],
              ),
              const Padding(padding: EdgeInsets.all(12)),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Current status:',
                    ),
                  ),
                  Expanded(flex: 1, child: Text(widget.task.status.name)),
                ],
              ),
              const Padding(padding: EdgeInsets.all(12)),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Current status:',
                    ),
                  ),
                  Expanded(flex: 1, child: Text(widget.task.destination)),
                ],
              ),
              const Padding(padding: EdgeInsets.all(12)),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Curator:',
                    ),
                  ),
                  Expanded(flex: 1, child: Text(widget.task.curator.fio)),
                ],
              ),
              const Padding(padding: EdgeInsets.all(12)),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Priority:',
                    ),
                  ),
                  Expanded(
                      flex: 1, child: Text(widget.task.priority.toString())),
                ],
              ),
              const Padding(padding: EdgeInsets.all(12)),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Creation date:',
                    ),
                  ),
                  Expanded(flex: 1, child: Text(widget.task.creationDate)),
                ],
              ),
              const Padding(padding: EdgeInsets.all(20)),
              if (currRole == 'HARVEST_OPERATOR' ||
                  currRole == 'PROCESSING_OPERATOR')
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () {},
                  child: const Text(
                    'Accept Task',
                    style: TextStyle(color: Colors.black87, fontSize: 32),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
