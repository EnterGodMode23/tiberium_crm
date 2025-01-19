import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/features/app/theme.dart';
import 'package:tiberium_crm/infra/network/base/shared_prefs_keys.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppRouter router;
  late Locale locale;

  late Future _future;

  @override
  void initState() {
    router = AppRouter();
    _future = initializeApp(router);

    super.initState();
  }

  @override
  void dispose() {
    router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _future,
        builder: (context, snap) => MaterialApp.router(
          theme: Themes.light,
          routerDelegate: router.delegate(),
          routeInformationParser: router.defaultRouteParser(),
        ),
      );

  Future<void> initializeApp(AppRouter router) async {
    final storage = GetIt.I<SharedPreferences>();
    final user = storage.getString(userKey);
    user != null
        ? router.replaceAll(const [HomeRoute()])
        : router.replaceAll(const [AuthRoute()]);
  }
}
