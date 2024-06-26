import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


GetIt locator = GetIt.instance;

Future<void> initializeDI() async {
  final storage = await SharedPreferences.getInstance();
  storage.clear();
  locator.registerSingleton<SharedPreferences>(storage);
}
