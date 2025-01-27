import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/tasks/processing_task.dart';
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
                      widget.task.uid ?? 'Unknown',
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
                  Expanded(
                      flex: 1, child: Text(widget.task.runtimeType.toString())),
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
                  Expanded(flex: 1, child: Text(widget.task.status ?? 'TO_DO')),
                ],
              ),
              const Padding(padding: EdgeInsets.all(12)),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Target Destination:',
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Text(widget.task.destination ?? 'Unknown')),
                ],
              ),
              const Padding(padding: EdgeInsets.all(12)),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Operator:',
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child:
                          Text('${widget.task.processingOperator?.firstName} '
                              '${widget.task.processingOperator?.lastName}')),
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
                    flex: 1,
                    child: Text(widget.task.priority.toString()),
                  ),
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
                  Expanded(
                      flex: 1, child: Text(widget.task.created ?? 'Unknown')),
                ],
              ),
              const Padding(padding: EdgeInsets.all(20)),
              if ((currRole == 'HARVEST_OPERATOR' ||
                      currRole == 'PROCESSING_OPERATOR') &&
                  widget.task.status != 'IN_PROGRESS')
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () async {
                    final res = await rep.patchProcessingTasks(
                      widget.task.uid ?? 'NONE',
                      '{"status": "IN_PROGRESS"}',
                    );
                    if (res.data.uid?.isNotEmpty ?? false) {
                      print(res);
                      AutoRouter.of(context).maybePop(true);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text('Incorrect input'),
                          );
                        },
                      );
                      AutoRouter.of(context).maybePop(false);
                    }
                  },
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
