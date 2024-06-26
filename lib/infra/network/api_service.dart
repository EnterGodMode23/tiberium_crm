
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:tiberium_crm/data/models/auth_response.dart';
import 'package:tiberium_crm/data/models/sms_login_req.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task_list.dart';
import 'package:tiberium_crm/data/models/users_list.dart';
import 'package:tiberium_crm/infra/network/base/server_urls.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: host)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @POST(authSms)
  Future<AuthResponse> smsLogin({
    @Body() required final SmsLoginReq smsLoginReq,
  });

  @GET(getUsersUrl)
  Future<UsersList> getUsers({
    @Query('role') required final String role,
  });

  @GET(getHarvestTasksUrl)
  Future<HarvestTaskList> getHarvestTasks();
}
