import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/create_new_proc_task_req.dart';
import 'package:tiberium_crm/data/models/create_new_task_req.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task_list.dart';
import 'package:tiberium_crm/data/models/tasks/processing_task.dart';
import 'package:tiberium_crm/data/models/tasks/processing_task_list.dart';
import 'package:tiberium_crm/data/models/users_list.dart';
import 'package:tiberium_crm/infra/network/api_service.dart';
import 'package:get_it/get_it.dart';

class Repository {
  final ApiService client;
  final SharedPreferences localStorage = GetIt.I.get();

  Repository(this.client);

  Future<UsersList> getUsers() async =>
      await client.getUsers(role:
      localStorage.getString('role') == 'HARVEST_MANAGER' ?
      'HARVEST_OPERATOR' : 'PROCESSING_OPERATOR',);

  Future<HarvestTaskList> getHarvestTasks() async =>
      await client.getHarvestTasks();

  Future<HarvestTask> postHarvestTask(CreateNewTaskReq req) async {
    final resp = await client.postHarvestTask(createReq: req);
    return resp;
  }

  Future<HarvestTask> patchHarvestTasks(String uid, String hTask) async =>
      await client.patchHarvestTasks(id: uid, hTask: hTask);

  Future<ProcessingTaskList> getProcessingTasks() async =>
      await client.getProcessingTasks();

  Future<ProcessingTask> postProcessingTask(CreateNewProcTaskReq req) async {
    final resp = await client.postProcessingTask(createReq: req);
    return resp;
  }

  Future<ProcessingTask> patchProcessingTasks(String uid, String pTask) async =>
      await client.patchProcessingTasks(id: uid, pTask: pTask);
}
