import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiberium_crm/features/app/di.dart';

import '../../../app.dart';

mixin InitHelper {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    App.initStorage();
    
    _setSystemUiMode();
    initializeDI();
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

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
}