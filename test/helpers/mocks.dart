import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/repos/repository.dart';
import 'package:tiberium_crm/repos/auth_repository.dart';

@GenerateMocks([
  Repository,
  AuthRepository,
  SharedPreferences,
])
void main() {} 