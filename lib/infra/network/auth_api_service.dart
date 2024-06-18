
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:tiberium_crm/data/models/auth_response.dart';
import 'package:tiberium_crm/data/models/sms_login_req.dart';
import 'package:tiberium_crm/infra/network/base/server_urls.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: host)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST(authSms)
  Future<AuthResponse> smsLogin({
    @Body() required final SmsLoginReq smsLoginReq,
  });
}
