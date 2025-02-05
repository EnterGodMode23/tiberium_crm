import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/create_new_proc_task_req.dart';
import 'package:tiberium_crm/data/models/create_new_harvest_task_req.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task.dart';
import 'package:tiberium_crm/data/models/tasks/main_task.dart';
import 'package:tiberium_crm/data/models/user.dart';
import 'package:tiberium_crm/repos/repository.dart';

@RoutePage()
class NewTaskPage extends StatefulWidget {
  final Role currRole;

  const NewTaskPage(
    this.currRole, {
    super.key,
  });

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  late final GlobalKey<FormBuilderState> _taskFormKey;
  final SharedPreferences localStorage = GetIt.I.get();
  final rep = GetIt.I.get<Repository>();
  late String currOperatorId;
  String? currMainTaskRef;
  HarvestTask? currHarvestTask;
  String? destination;

  List<DropdownMenuItem<User>> users = [];
  List<DropdownMenuItem<MainTask>> mainTasks = [];
  List<DropdownMenuItem<HarvestTask>> harvestTasks = [];

  MainTask? currMainTask;

  @override
  void initState() {
    _taskFormKey = GlobalKey();
    _getOperators();
    _getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FormBuilder(
        key: _taskFormKey,
        child: Scaffold(
          appBar: AppBar(
            title: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'New Task',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 36),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Column(
                  children: [
                    FormBuilderDropdown(
                      key: const Key('operator'),
                      name: 'operator',
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        labelText: 'Operator',
                      ),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            errorText: 'Enter the task\'s operator',
                          ),
                        ],
                      ),
                      onChanged: (value) =>
                          currOperatorId = value?.uid ?? 'Unknown',
                      items: users,
                    ),
                    const SizedBox(height: 16),
                    widget.currRole == Role.harvestManager
                        ? FormBuilderDropdown(
                            name: 'mainTaskRef',
                            onChanged: (value) {
                              setState(() {
                                currMainTask = value;
                                currMainTaskRef = currMainTask?.uid;
                                destination = currMainTask?.destination;
                                _taskFormKey.currentState?.fields['destination']
                                    ?.didChange(destination);
                              });
                            },
                            items: mainTasks,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              labelText: 'Main task',
                            ),
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                  errorText: 'Enter the main task',
                                ),
                              ],
                            ),
                          )
                        : FormBuilderDropdown(
                            name: 'harvsetTaskId',
                            onChanged: (value) =>
                                setState(() => currHarvestTask = value),
                            items: harvestTasks,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              labelText: 'Harvest task',
                            ),
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                  errorText: 'Enter the harvest task',
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(height: 16),
                    FormBuilderDropdown(
                      key: const Key('priority'),
                      name: 'priority',
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        labelText: 'Priority',
                      ),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            errorText: 'Enter the priority',
                          ),
                        ],
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 1,
                          child: Text('1'),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text('2'),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: Text('3'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      key: const Key('kilos'),
                      name: 'kilos',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        labelText: 'Tiberium amount',
                      ),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            errorText: 'Enter the tiberium amount',
                          ),
                          FormBuilderValidators.numeric(
                            errorText: 'Enter a valid number',
                          ),
                          FormBuilderValidators.min(
                            0,
                            errorText: 'Amount must be greater than 0',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  child: ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: () => widget.currRole == Role.harvestManager
                        ? _createHarvestTask()
                        : _createProcessingTask(),
                    child: Text(
                      'Create task',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 36),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Future<void> _createProcessingTask() async {
    if (_taskFormKey.currentState?.saveAndValidate() != true) {
      return;
    }

    try {
      final res = await rep.postProcessingTask(
        CreateNewProcTaskReq(
          harvestTaskId: currHarvestTask?.uid ?? 'Unknown',
          processingOperator: currOperatorId,
          destination: (widget.currRole == Role.processingManager
                  ? currHarvestTask?.destination
                  : destination) ??
              'Unknown destination',
          priority: _taskFormKey.currentState!.value['priority'],
          mainTaskRef: currHarvestTask?.mainTaskRef ?? 'Unknown main task ref',
          killos: double.parse(_taskFormKey.currentState!.value['kilos']),
          status: 'TO_DO',
        ),
      );
      AutoRouter.of(context).maybePop(res.data.uid?.isNotEmpty ?? false);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create task: $e')),
        );
      }
    }
  }

  Future<void> _createHarvestTask() async {
    if (_taskFormKey.currentState?.saveAndValidate() != true) {
      return;
    }

    try {
      final res = await rep.postHarvestTask(
        CreateNewHarvestTaskReq(
          harvestOperator: currOperatorId,
          destination: destination ?? 'Unknown',
          priority: _taskFormKey.currentState!.value['priority'],
          mainTaskRef: currMainTaskRef ?? 'Unknown main task ref',
          killos: double.parse(_taskFormKey.currentState!.value['kilos']),
          status: 'TO_DO',
        ),
      );
      AutoRouter.of(context).maybePop(res.data.uid.isNotEmpty);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create task: $e')),
        );
      }
    }
  }

  Future<void> _getOperators() async {
    final list = await rep.getUsers();

    final items = list.users
        ?.map(
          (user) => DropdownMenuItem(
            value: user,
            child: Text('${user.firstName}  ${user.lastName}'),
          ),
        )
        .toList();
    if (mounted) {
      setState(() => users = items ?? []);
    }
  }

  Future<void> _getTasks() async {
    final list = await rep.getMainTasks();

    final items = list.data
        .map(
          (task) => DropdownMenuItem(
            value: task,
            child: Text(task.destination),
          ),
        )
        .toList();
    if (mounted) {
      setState(() => mainTasks = items);
    }

    _getHarvestTasks();
  }

  Future<void> _getHarvestTasks() async {
    final list = await rep.getHarvestTasks();

    final items = list.harvestTasks
        ?.map(
          (task) => DropdownMenuItem(
            value: task,
            child: Text(task.destination ?? 'Unknown'),
          ),
        )
        .toList();
    if (mounted) {
      setState(() => harvestTasks = items ?? []);
    }
  }
}
