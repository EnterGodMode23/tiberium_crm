import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/data/models/sms_login_req.dart';
import 'package:tiberium_crm/infra/network/auth_api_service.dart';
import 'package:tiberium_crm/infra/network/base/shared_prefs_keys.dart';

class AuthRepository {
  final AuthApiService _authClient;
  final SharedPreferences _storage;

  AuthRepository(this._authClient, this._storage);

  Future<bool> smsLogin(SmsLoginReq req) async {
    try {
      final response = await _authClient.smsLogin(smsLoginReq: req);
      if (response.data?.user != null) {
        _storage.setString(userKey, jsonEncode(response.data!.user));
        _storage.setString(tokenKey, response.data!.accessToken);
        _storage.setString(roleKey, response.data!.user.role.toStringX());
        return true;
      }
      return false;
    } catch (E) {
      return false;
    }
  }
}
