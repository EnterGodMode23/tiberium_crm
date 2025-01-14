import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/infra/network/api_service.dart';
import 'package:tiberium_crm/infra/network/auth_api_service.dart';
import 'package:tiberium_crm/infra/network/base/server_urls.dart';

import 'package:dio/dio.dart';
import 'package:tiberium_crm/infra/network/interceptor.dart';
import 'package:tiberium_crm/repos/auth_repository.dart';
import 'package:tiberium_crm/repos/repository.dart';

GetIt locator = GetIt.instance;

Future<void> initializeDI() async {
  final storage = locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  final authClient = locator.registerSingleton<AuthApiService>(
    AuthApiService(
      Dio(BaseOptions(contentType: 'application/json', baseUrl: host)),
    ),
  );

  locator
      .registerSingleton<AuthRepository>(AuthRepository(authClient, storage));

  final loggingInterceptor = locator.registerSingleton<LoggingInterceptor>(
    LoggingInterceptor((storage.getString('token') ?? '')),
  );

  final apiService = locator.registerSingleton<ApiService>(
    ApiService(
      Dio(BaseOptions(contentType: 'application/json', baseUrl: host))
        ..interceptors.add(loggingInterceptor),
    ),
  );

  locator.registerSingleton<Repository>(Repository(apiService));
}
