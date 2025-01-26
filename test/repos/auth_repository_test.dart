import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/sms_login_req.dart';
import 'package:tiberium_crm/infra/network/auth_api_service.dart';
import 'package:tiberium_crm/repos/auth_repository.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/infra/network/base/shared_prefs_keys.dart';
import 'package:tiberium_crm/data/models/user.dart';
import 'package:tiberium_crm/data/models/auth_response.dart';
import 'package:tiberium_crm/data/models/auth_response_data.dart';
import 'dart:convert';

@GenerateNiceMocks([
  MockSpec<AuthApiService>(),
  MockSpec<SharedPreferences>(),
])
import 'auth_repository_test.mocks.dart';

void main() {
  late AuthRepository authRepository;
  late MockAuthApiService mockAuthClient;
  late MockSharedPreferences mockStorage;

  setUp(() {
    mockAuthClient = MockAuthApiService();
    mockStorage = MockSharedPreferences();
    authRepository = AuthRepository(mockAuthClient, mockStorage);
  });

  group('AuthRepository', () {
    const testPhone = '+79001234567';
    const testCode = '0090';

    test('smsLogin - successful login stores user data', () async {
      final loginReq = SmsLoginReq(phoneNumber: testPhone, smsCode: testCode);
      
      final testUser = User(
        uid: '123',
        phoneNumber: testPhone,
        role: Role.harvestManager,
        firstName: 'Test',
        lastName: 'User',
      );

      final authResponse = AuthResponse(
        data: AuthResponseData(
          user: testUser,
          accessToken: 'test_token',
          firstAuth: false,
        ),
      );

      when(mockAuthClient.smsLogin(smsLoginReq: loginReq))
          .thenAnswer((_) async => authResponse);
      
      when(mockStorage.setString(any, any)).thenAnswer((_) async => true);

      final result = await authRepository.smsLogin(loginReq);

      expect(result, true);
      
      verify(mockStorage.setString(userKey, jsonEncode(testUser.toJson()))).called(1);
      verify(mockStorage.setString(tokenKey, 'test_token')).called(1);
      verify(mockStorage.setString(roleKey, Role.harvestManager.toStringX())).called(1);
    });

    test('smsLogin - failed login returns false', () async {
      final loginReq = SmsLoginReq(phoneNumber: testPhone, smsCode: 'wrong_code');
      
      when(mockAuthClient.smsLogin(smsLoginReq: loginReq))
          .thenThrow(Exception('Invalid code'));

      final result = await authRepository.smsLogin(loginReq);

      expect(result, false);
      verifyNever(mockStorage.setString(any, any));
    });

    test('smsLogin - null response data returns false', () async {
      final loginReq = SmsLoginReq(phoneNumber: testPhone, smsCode: testCode);
      
      when(mockAuthClient.smsLogin(smsLoginReq: loginReq))
          .thenAnswer((_) async => AuthResponse(data: null));

      final result = await authRepository.smsLogin(loginReq);

      expect(result, false);
      verifyNever(mockStorage.setString(any, any));
    });
  });
} 