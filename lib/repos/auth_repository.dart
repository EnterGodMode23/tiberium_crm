import 'dart:async';

import 'package:tiberium_crm/data/models/sms_login_req.dart';
import 'package:tiberium_crm/infra/network/auth_api_service.dart';

class AuthRepository {
  final AuthApiService authClient;

  AuthRepository(this.authClient);

  Future<bool> smsLogin(SmsLoginReq req) async {
    final futureResponse = await authClient.smsLogin(smsLoginReq: req);
    if (futureResponse.data != null) return true;
    return false;
  }
}
