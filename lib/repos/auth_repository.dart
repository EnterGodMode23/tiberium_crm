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
    try {
      final response = await _authClient.smsLogin(smsLoginReq: req);
      if (response.data?.user != null) {
        _storage.setString('user', jsonEncode(response.data!.user));
        _storage.setString('token', response.data!.accessToken);
        return true;
      }
      return false;
    } catch (E) {
      return false;
    }
  }
}
