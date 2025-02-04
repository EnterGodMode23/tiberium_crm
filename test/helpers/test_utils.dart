import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/repos/auth_repository.dart';
import 'package:tiberium_crm/repos/repository.dart';
import 'mocks.mocks.dart';

final _appRouter = AppRouter();

Future<void> setupTestDependencies() async {
  final getIt = GetIt.instance;
  
  final mockRepo = MockRepository();
  final mockAuthRepo = MockAuthRepository();
  final mockPrefs = MockSharedPreferences();

  if (!getIt.isRegistered<Repository>()) {
    getIt.registerSingleton<Repository>(mockRepo);
  }
  if (!getIt.isRegistered<AuthRepository>()) {
    getIt.registerSingleton<AuthRepository>(mockAuthRepo);
  }
  if (!getIt.isRegistered<SharedPreferences>()) {
    getIt.registerSingleton<SharedPreferences>(mockPrefs);
  }
}

extension PumpApp on WidgetTester {
  Future<void> pumpTheWidget(Widget widget) async {
    await setupTestDependencies();

    return pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: RouterScope(
            controller: _appRouter,
            stateHash: 0,
            inheritableObserversBuilder: () => [AutoRouteObserver()],
            child: MediaQuery(
              data: const MediaQueryData(),
              child: Material(child: widget),
            ),
          ),
        ),
      ),
    );
  }
} 