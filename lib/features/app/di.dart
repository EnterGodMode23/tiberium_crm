import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tiberium_crm/infra/network/auth_api_service.dart';
import 'package:tiberium_crm/infra/network/auth_interceptor.dart';
import 'package:tiberium_crm/infra/network/base/server_urls.dart';
import 'package:tiberium_crm/infra/network/interceptor.dart';
import 'package:tiberium_crm/repos/auth_repository.dart';

GetIt locator = GetIt.instance;

Future<void> initializeDI() async {
  locator.registerFactory<LoggingInterceptor>(() => LoggingInterceptor(''));

  final authClient = AuthApiService(
    Dio(BaseOptions(contentType: 'application/json', baseUrl: host))
      ..interceptors.add(AuthInterceptor()),
  );
  locator.registerSingleton(authClient);

  final authRepository = AuthRepository();
  locator.registerSingleton<AuthRepository>(authRepository);
}
