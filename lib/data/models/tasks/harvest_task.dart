import 'package:tiberium_crm/data/models/user.dart';

class HarvestTask{
  String? uid;
  String? created;
  String? updated;
  User? harvestOperator;
  User? harvestManager;
  num? targetKilosToHarvest;
  int? priority;
  String? status;
  String? mainTaskRef;
  String? destination;

  HarvestTask({
    this.uid,
    this.created,
    this.updated,
    this.harvestOperator,
    this.harvestManager,
    this.targetKilosToHarvest,
    this.priority,
    this.status,
    this.mainTaskRef,
    this.destination
  });

  HarvestTask.fromJson(Map<String, dynamic> json) {
    // TODO это говно надо убрать, просто с сервера приходит в другом формате на POST
    if (json['data'] != null) {
      uid = json['data']['uid'];
      created = json['data']['created'];
      updated = json['data']['updated'];
      harvestOperator = User(firstName: 'Test', lastName: 'Test');
      harvestManager = null;
      targetKilosToHarvest = json['data']['target_kilos_to_harvest'];
      priority = json['data']['priority'];
      status = json['data']['status'];
      mainTaskRef = json['data']['main_task_ref'];
      destination = json['data']['destination'];
    }
    else {
      uid = json['uid'];
      created = json['created'];
      updated = json['updated'];
      try {
        harvestOperator = User.fromJson(json['harvest_operator']);
        harvestManager = User.fromJson(json['harvest_manager']);
      }catch(e) {
        harvestOperator = User(firstName: 'Test', lastName: 'Test');
        harvestManager = null;
      }
      targetKilosToHarvest = json['target_kilos_to_harvest'];
      priority = json['priority'];
      status = json['status'];
      mainTaskRef = json['main_task_ref'];
      destination = json['destination'];
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['created'] = created;
    data['updated'] = updated;
    data['harvest_operator'] = harvestOperator;
    data['harvest_manager'] = harvestManager;
    data['target_kilos_to_harvest'] = targetKilosToHarvest;
    data['priority'] = priority;
    data['status'] = status;
    data['main_task_ref'] = mainTaskRef;
    data['destination'] = destination;
    return data;
  }
}