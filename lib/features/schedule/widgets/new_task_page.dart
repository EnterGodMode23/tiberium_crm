import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/create_new_proc_task_req.dart';
import 'package:tiberium_crm/data/models/create_new_harvest_task_req.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/data/models/tasks/main_task.dart';
import 'package:tiberium_crm/data/models/user.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
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
  late String currUid;
  String? currMainTaskRef;
  String? destination;

  List<DropdownMenuItem<User>> users = [];
  List<DropdownMenuItem<MainTask>> mainTasks = [];

  MainTask? currMainTask;

  @override
  void initState() {
    _taskFormKey = GlobalKey();
    _getOperators();
    _getMainTasks();
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
                            errorText: 'Enter the task\'s destination',
                          ),
                        ],
                      ),
                      onChanged: (value) => currUid = value?.uid ?? 'Unknown',
                      items: users,
                    ),
                    const SizedBox(height: 16),
                    FormBuilderDropdown(
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
                    ),
                    const SizedBox(height: 16),
                    FormBuilderDropdown(
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
                      'Create Task',
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

    final res = await rep.postProcessingTask(
      CreateNewProcTaskReq(
        processingOperator: currUid,
        destination: destination ?? 'Unknown',
        priority: _taskFormKey.currentState!.value['priority'],
        mainTaskRef: currMainTaskRef ?? 'Unknown main task ref',
        killos: _taskFormKey.currentState!.value['kilos'],
        status: 'TO_DO',
      ),
    );

    if (res.uid?.isNotEmpty ?? false) {
      print(res);
      AutoRouter.of(context).navigate(ProcessingTaskRoute(task: res));
      AutoRouter.of(context).maybePop(true);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          title: Text('Incorrect input'),
        ),
      );
      AutoRouter.of(context).navigate(const ScheduleRoute());
      AutoRouter.of(context).maybePop(false);
    }
  }

  Future<void> _createHarvestTask() async {
    if (_taskFormKey.currentState?.saveAndValidate() != true) {
      return;
    }

    final res = await rep.postHarvestTask(
      CreateNewHarvestTaskReq(
        processingOperator: currUid,
        destination: destination ?? 'Unknown',
        priority: _taskFormKey.currentState!.value['priority'],
        mainTaskRef: currMainTaskRef ?? 'Task ref is null',
        killos: int.parse(_taskFormKey.currentState!.value['kilos']),
        status: 'TO_DO',
      ),
    );

    if (res.data.uid.isNotEmpty) {
      print(res);
      AutoRouter.of(context).navigate(HarvestTaskRoute(task: res.data));
      AutoRouter.of(context).maybePop(true);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          title: Text('Incorrect input'),
        ),
      );
      AutoRouter.of(context).navigate(const ScheduleRoute());
      AutoRouter.of(context).maybePop(false);
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

  Future<void> _getMainTasks() async {
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
  }
}
