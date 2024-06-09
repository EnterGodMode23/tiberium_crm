import 'package:flutter/material.dart';
import 'package:tiberium_crm/app.dart';
import 'package:tiberium_crm/features/app/helpers/init_helper.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';

final appRouter = AppRouter();

void main() async {
  await InitHelper.init();
  runApp(const App());
}
