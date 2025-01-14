import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/sms_login_req.dart';
import 'package:tiberium_crm/infra/network/auth_api_service.dart';

class AuthRepository {
  final AuthApiService _authClient;
  final SharedPreferences _storage;

  AuthRepository(this._authClient, this._storage);

  Future<bool> smsLogin(SmsLoginReq req) async {
    final response = await _authClient.smsLogin(smsLoginReq: req);
    _storage.setString('user', jsonEncode(response.data?.user));
    _storage.setString('role', response.data?.user?.role ?? '');
    _storage.setString('token', response.data?.accessToken ?? '');
    if (response.data != null) return true;
    return false;
  }
}
