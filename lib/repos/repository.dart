import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/data/models/tasks/harvest_task_list.dart';
import 'package:tiberium_crm/data/models/users_list.dart';
import 'package:tiberium_crm/infra/network/api_service.dart';
import 'package:get_it/get_it.dart';

class Repository {
  final ApiService client;
  final SharedPreferences localStorage = GetIt.I.get();

  Repository(this.client);

  Future<UsersList> getUsers() async =>
      await client.getUsers(role: localStorage.getString('role') ?? '');

  Future<HarvestTaskList> getHarvestTasks() async =>
      await client.getHarvestTasks();
}
