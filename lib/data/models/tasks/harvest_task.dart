import 'package:tiberium_crm/data/models/user.dart';

class HarvestTask {
  String uid;
  String? created;
  String? updated;
  User? harvestOperator;
  User harvestManager;
  double? targetKilosToHarvest;
  int? priority;
  String status;
  String mainTaskRef;
  String? destination;

  HarvestTask({
    required this.uid,
    this.created,
    this.updated,
    this.harvestOperator,
    required this.harvestManager,
    this.targetKilosToHarvest,
    this.priority,
    required this.status,
    required this.mainTaskRef,
    this.destination,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'created': created,
        'updated': updated,
        'harvest_operator': harvestOperator?.toJson(),
        'harvest_manager': harvestManager.toJson(),
        'target_kilos_to_harvest': targetKilosToHarvest,
        'priority': priority,
        'status': status,
        'main_task_ref': mainTaskRef,
        'destination': destination,
      };

  factory HarvestTask.fromJson(Map<String, dynamic> json) => HarvestTask(
        uid: json['uid'],
        created: json['created'],
        updated: json['updated'],
        harvestOperator: json['harvest_operator'] != null
            ? User.fromJson(json['harvest_operator'])
            : null,
        harvestManager: User.fromJson(json['harvest_manager']),
        targetKilosToHarvest: json['target_kilos_to_harvest'],
        priority: json['priority'],
        status: json['status'],
        mainTaskRef: json['main_task_ref'],
        destination: json['destination'],
      );
}
