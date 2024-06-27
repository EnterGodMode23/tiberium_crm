// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/app.dart';
import 'package:tiberium_crm/data/models/sms_login_req.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/features/app/theme.dart';
import 'package:tiberium_crm/infra/network/api_service.dart';
import 'package:tiberium_crm/infra/network/auth_api_service.dart';
import 'package:tiberium_crm/infra/network/auth_interceptor.dart';
import 'package:tiberium_crm/infra/network/base/server_urls.dart';
import 'package:tiberium_crm/infra/network/interceptor.dart';
import 'package:tiberium_crm/repos/auth_repository.dart';
import 'package:tiberium_crm/repos/repository.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final GlobalKey<FormBuilderState> _formKey;
  late final AuthRepository rep;

  @override
  void initState() {
    _authService();
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.light,
      home: FormBuilder(
        key: _formKey,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset('assets/logo.svg'),
                Column(
                  children: [
                    FormBuilderTextField(
                      name: 'phone',
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                      ),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            errorText: 'Enter your phone',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 34),
                    FormBuilderTextField(
                      name: 'sms',
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        labelText: 'Password',
                      ),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            errorText: 'Enter sms code',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.saveAndValidate() != true) {
                      return;
                    }
                    final res = await rep.smsLogin(
                      SmsLoginReq(
                        phoneNumber: _formKey.currentState!.value['phone'],
                        smsCode: _formKey.currentState!.value['sms'],
                      ),
                    );
                    if (res) {
                      _DI();
                      AutoRouter.of(context).replaceAll(const [HomeRoute()]);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text('Incorrect number or sms code'),
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(56),
                  ),
                  child: const Text('Sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _DI() async{
    GetIt locator = GetIt.instance;

    final header = (locator.get<SharedPreferences>().getString('token') ?? '');
    App.mainInterceptor = LoggingInterceptor(header);
    final client = ApiService(
      Dio(BaseOptions(contentType: 'application/json', baseUrl: host))
        ..interceptors.add(App.mainInterceptor),
    );

    final repository = Repository(client);
    App.repository = repository;
  }

  Future<void> _authService() async{
    final authClient = AuthApiService(
      Dio(BaseOptions(contentType: 'application/json', baseUrl: host))
        ..interceptors.add(AuthInterceptor()),
    );
    App.authAPI = authClient;

    rep = AuthRepository(authClient);
  }
}
