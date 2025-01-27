import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/create_new_main_task_req.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/data/models/user.dart';
import 'package:tiberium_crm/repos/repository.dart';

@RoutePage()
class NewPlanPage extends StatefulWidget {
  const NewPlanPage({super.key});

  @override
  State<NewPlanPage> createState() => _NewPlanPageState();
}

class _NewPlanPageState extends State<NewPlanPage> {
  late final Role currRole;
  late final GlobalKey<FormBuilderState> _taskFormKey;
  final SharedPreferences localStorage = GetIt.I.get();
  final rep = GetIt.I.get<Repository>();

  String currProcessingUid = '';
  String currHarvestUid = '';

  List<DropdownMenuItem<User>> processingManagers = [];
  List<DropdownMenuItem<User>> harvestManagers = [];

  @override
  void initState() {
    _taskFormKey = GlobalKey();
    currRole = _getCurrRole();
    _getManagers();
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
                  'New Plan',
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
                    const SizedBox(height: 16),
                    FormBuilderDropdown(
                      name: 'harvest_manager_id',
                      onChanged: (value) =>
                          currHarvestUid = value?.uid ?? 'Unknown',
                      items: harvestManagers,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        labelText: 'Mining curator',
                      ),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            errorText: 'Enter the mining curator',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderDropdown(
                      name: 'proc_manager_id',
                      onChanged: (value) =>
                          currProcessingUid = value?.uid ?? 'Unknown',
                      items: processingManagers,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        labelText: 'Processing curator',
                      ),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            errorText: 'Enter the processing curator',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'amount',
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
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'destination',
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        labelText: 'Destination',
                      ),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            errorText: 'Enter the destination',
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
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  child: ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: () async {
                      if (_taskFormKey.currentState?.saveAndValidate() !=
                          true) {
                        return;
                      }
                      try {
                        await rep.postMainTask(
                          CreateNewMainTaskReq(
                            processingManagerId: currProcessingUid,
                            harvestManagerId: currHarvestUid,
                            targetKilosToSale: double.tryParse(
                              _taskFormKey.currentState!.value['amount'],
                            ),
                            destination:
                                _taskFormKey.currentState!.value['destination'],
                            priority:
                                _taskFormKey.currentState!.value['priority'],
                            status: 'TO_DO',
                          ),
                        );
                        AutoRouter.of(context).pop();
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to create plan: $e'),
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      'Create plan',
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

  Role _getCurrRole() =>
      RoleExtension.fromString(localStorage.getString('role')!);

  Future<void> _getManagers() async {
    final list = await rep.getUsers();

    final processing =
        list.users?.where((user) => user.role == Role.processingManager).map(
              (user) => DropdownMenuItem(
                value: user,
                child: Text('${user.firstName}  ${user.lastName}'),
              ),
            );

    final harvest =
        list.users?.where((user) => user.role == Role.harvestManager).map(
              (user) => DropdownMenuItem(
                value: user,
                child: Text('${user.firstName}  ${user.lastName}'),
              ),
            );
    if (mounted) {
      setState(() {
        processingManagers.addAll(processing ?? []);
        harvestManagers.addAll(harvest ?? []);
      });
    }
  }
}
