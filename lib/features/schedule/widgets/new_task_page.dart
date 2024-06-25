import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tiberium_crm/app.dart';

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

  @override
  void initState() {
    _taskFormKey = GlobalKey();
    currRole = App.localStorage.getString('role') ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
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
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'Operator:',
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: FormBuilderTextField(
                            name: 'operator',
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'UID',
                            ),
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                  errorText: 'Enter the operator\'s UID',
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
                          flex: 1,
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
                          flex: 1,
                          child: FormBuilderTextField(
                            name: 'Priority',
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
              Spacer(),
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () async {
                  if (_taskFormKey.currentState?.saveAndValidate() != true) {
                    return;
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
