import 'package:flutter/material.dart';
import 'package:tiberium_crm/features/app/helpers/init_helper.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/features/splash/splash_screen.dart';

final appRouter = AppRouter();

void main() async {
  await InitHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config(),
    );
  }
}
