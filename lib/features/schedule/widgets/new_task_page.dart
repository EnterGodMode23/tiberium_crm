import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/app.dart';
import 'package:tiberium_crm/data/models/create_new_task_req.dart';
import 'package:tiberium_crm/data/models/user.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/repos/repository.dart';

@RoutePage()
class NewTaskPage extends StatefulWidget {
  const NewTaskPage({
    super.key,
  });

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  late final String currRole;
  late final GlobalKey<FormBuilderState> _taskFormKey;
  final SharedPreferences localStorage = GetIt.I.get();
  final rep = GetIt.I.get<Repository>();
  late String currUid;

  List<DropdownMenuItem<User>>? users = [];

  @override
  void initState() {
    _taskFormKey = GlobalKey();
    currRole = localStorage.getString('role') ?? '';
    _getOperators();
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
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          'Task Draft:',
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: FormBuilderDropdown(
                              name: 'user',
                              borderRadius: BorderRadius.circular(14),
                              decoration: const InputDecoration(
                                labelText: 'Workers',
                                border: InputBorder.none,
                              ),
                              items: users ?? [],
                              onChanged: (value) {
                                final user = value as User;
                                currUid = user.uid ?? 'Unknown';
                              },
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(
                                    errorText: 'Choose worker',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(12)),
                      Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              'Destination:',
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: FormBuilderTextField(
                              name: 'destination',
                              keyboardType: TextInputType.text,
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(
                                    errorText: 'Enter the task\'s destination',
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                            flex: 2,
                            child: FormBuilderTextField(
                              name: 'priority',
                              keyboardType: TextInputType.text,
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(
                                    errorText: 'Enter the task\'s priority',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(20)),
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () async {
                    if (_taskFormKey.currentState?.saveAndValidate() != true) {
                      return;
                    }
                    final res = await rep.postHarvestTask(
                      CreateNewTaskReq(
                        harvestOperator: currUid,
                        destination:
                            _taskFormKey.currentState!.value['destination'],
                        priority: int.parse(
                            _taskFormKey.currentState!.value['priority']),
                      ),
                    );
                    if (res.uid?.isNotEmpty ?? false) {
                      print(res);
                      AutoRouter.of(context).navigate(TaskRoute(task: res));
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
                      AutoRouter.of(context).navigate(const ScheduleRoute());
                      AutoRouter.of(context).maybePop(false);
                    }
                  },
                  child: const Text(
                    'Create Task',
                    style: TextStyle(color: Colors.black87, fontSize: 32),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Future<void> _getOperators() async {
    final list = await rep.getUsers();

    final items = list.users?.map((user) {
      return DropdownMenuItem(
        value: user,
        child: Text('${user.firstName}  ${user.lastName}'),
      );
    }).toList();
    if (mounted) {
      setState(() {
        users = items;
      });
    }
  }
}
