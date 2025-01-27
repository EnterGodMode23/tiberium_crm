import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiberium_crm/features/app/di.dart';

mixin InitHelper {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    _setSystemUiMode();
    await Future.wait([initializeDI()]);
  }

  static void _setSystemUiMode() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
  }
}
