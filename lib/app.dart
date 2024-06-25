import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/features/app/theme.dart';

class App extends StatefulWidget {
  const App({super.key});
  static late SharedPreferences localStorage;
  @override
  State<App> createState() => _AppState();

  static Future initStorage() async {
    localStorage = await SharedPreferences.getInstance();
  }
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
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snap) {
        return MaterialApp.router(
          theme: Themes.light,
          routerDelegate: router.delegate(),
          routeInformationParser: router.defaultRouteParser(),
        );
      },
    );
  }

  Future<void> initializeApp(AppRouter router) async {
    return router.replaceAll(const [AuthRoute()]);
  }
}
