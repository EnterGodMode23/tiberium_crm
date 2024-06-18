import 'dart:async';

import 'package:tiberium_crm/data/models/sms_login_req.dart';
import 'package:tiberium_crm/infra/network/auth_api_service.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  late final AuthApiService authClient;

  AuthRepository() {
    authClient = GetIt.I.get<AuthApiService>();
  }

  Future<bool> smsLogin(SmsLoginReq req) async {
    final futureResponse = await authClient.smsLogin(smsLoginReq: req);
    if (futureResponse.data != null) return true;
    return false;
  }
}
