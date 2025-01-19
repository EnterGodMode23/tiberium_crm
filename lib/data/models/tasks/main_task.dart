import 'package:tiberium_crm/data/models/user.dart';

class MainTask {
  String uid;
  String? created;
  String? updated;
  User? harvestOperator;
  User harvestManager;
  num? targetKilosToHarvest;
  int? priority;
  String status;
  String? destination;

  MainTask({
    required this.uid,
    this.created,
    this.updated,
    this.harvestOperator,
    required this.harvestManager,
    this.targetKilosToHarvest,
    this.priority,
    required this.status,
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
        'destination': destination,
      };

  factory MainTask.fromJson(Map<String, dynamic> json) => MainTask(
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
        destination: json['destination'],
      );
}
