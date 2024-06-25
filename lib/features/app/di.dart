import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/infra/network/api_service.dart';
import 'package:tiberium_crm/infra/network/auth_api_service.dart';
import 'package:tiberium_crm/infra/network/auth_interceptor.dart';
import 'package:tiberium_crm/infra/network/base/server_urls.dart';
import 'package:tiberium_crm/infra/network/interceptor.dart';
import 'package:tiberium_crm/repos/auth_repository.dart';
import 'package:tiberium_crm/repos/repository.dart';

GetIt locator = GetIt.instance;

Future<void> initializeDI() async {
  final storage = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(storage);

  locator.registerLazySingleton<LoggingInterceptor>(
    () => LoggingInterceptor(storage.getString('token') ?? ''),
  );

  final authClient = AuthApiService(
    Dio(BaseOptions(contentType: 'application/json', baseUrl: host))
      ..interceptors.add(AuthInterceptor()),
  );
  locator.registerSingleton(authClient);

  final authRepository = AuthRepository();
  locator.registerSingleton<AuthRepository>(authRepository);

  final client = ApiService(
    Dio(BaseOptions(contentType: 'application/json', baseUrl: host))
      ..interceptors.add(locator.get<LoggingInterceptor>()),
  );
  locator.registerSingleton(client);

  final repository = Repository();
  locator.registerSingleton<Repository>(repository);
}
