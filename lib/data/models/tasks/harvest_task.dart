import 'package:tiberium_crm/data/models/user.dart';
import 'package:tiberium_crm/data/task_type.dart';

class HarvestTask{
  String? uid;
  String? created;
  String? updated;
  User? harvestOperator;
  User? harvestManager;
  num? targetKilosToHarvest;
  int? priority;
  TaskStatus? status;
  String? mainTaskRef;

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
  });

  HarvestTask.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    created = json['created'];
    updated = json['updated'];
    harvestOperator = json['harvest_operator'];
    harvestManager = json['harvest_manager'];
    targetKilosToHarvest = json['target_kilos_to_harvest'];
    priority = json['priority'];
    status = json['status'];
    mainTaskRef = json['main_task_ref'];
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
    return data;
  }
}