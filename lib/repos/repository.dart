import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/create_new_main_task_req.dart';
import 'package:tiberium_crm/data/models/create_new_proc_task_req.dart';
import 'package:tiberium_crm/data/models/create_new_harvest_task_req.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task_list.dart';
import 'package:tiberium_crm/data/models/tasks/main_task.dart';
import 'package:tiberium_crm/data/models/tasks/main_task_response.dart';
import 'package:tiberium_crm/data/models/tasks/processing_task.dart';
import 'package:tiberium_crm/data/models/tasks/processing_task_list.dart';
import 'package:tiberium_crm/data/models/tasks/single_harvest_task_response.dart';
import 'package:tiberium_crm/data/models/tasks/single_main_task_response.dart';
import 'package:tiberium_crm/data/models/users_list.dart';
import 'package:tiberium_crm/infra/network/api_service.dart';
import 'package:get_it/get_it.dart';

class Repository {
  final ApiService client;
  final SharedPreferences localStorage = GetIt.I.get();

  Repository(this.client);

  Future<UsersList> getUsers() async => await client.getUsers();

  Future<HarvestTaskList> getHarvestTasks() async =>
      await client.getHarvestTasks();

  Future<MainTaskResponse> getMainTasks() async => await client.getMainTasks();

  Future<SingleHarvestTaskResponse> postHarvestTask(
      CreateNewHarvestTaskReq req) async {
    final resp = await client.postHarvestTask(createReq: req);
    return resp;
  }

  Future<SingleMainTaskResponse> postMainTask(CreateNewMainTaskReq req) async {
    final resp = await client.postMainTask(createReq: req);
    return resp;
  }

  Future<SingleHarvestTaskResponse> patchHarvestTasks(String uid, String hTask) async =>
      await client.patchHarvestTasks(id: uid, hTask: hTask);

  Future<SingleMainTaskResponse> patchMainTasks(
          String uid, String hTask) async =>
      await client.patchMainTasks(id: uid, hTask: hTask);

  Future<ProcessingTaskList> getProcessingTasks() async =>
      await client.getProcessingTasks();

  Future<ProcessingTask> postProcessingTask(CreateNewProcTaskReq req) async {
    final resp = await client.postProcessingTask(createReq: req);
    return resp;
  }

  Future<ProcessingTask> patchProcessingTasks(String uid, String pTask) async =>
      await client.patchProcessingTasks(id: uid, pTask: pTask);
}
