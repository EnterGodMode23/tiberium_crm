import 'package:tiberium_crm/data/models/user.dart';

class MainTask {
  final String uid;
  final String salesManagerId;
  final String processingManagerId;
  final String harvestManagerId;
  final int targetKilosToSale;
  final int priority;
  final String destination;
  final String status;
  final User salesManager;
  final User processingManager;
  final User harvestManager;

  MainTask({
    required this.uid,
    required this.salesManagerId,
    required this.processingManagerId,
    required this.harvestManagerId,
    required this.targetKilosToSale,
    required this.priority,
    required this.destination,
    required this.status,
    required this.salesManager,
    required this.processingManager,
    required this.harvestManager,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'sales_manager_id': salesManagerId,
        'processing_manager_id': processingManagerId,
        'harvest_manager_id': harvestManagerId,
        'target_kilos_to_sale': targetKilosToSale,
        'priority': priority,
        'destination': destination,
        'status': status,
        'sales_manager': salesManager.toJson(),
        'processing_manager': processingManager.toJson(),
        'harvest_manager': harvestManager.toJson(),
      };

  factory MainTask.fromJson(Map<String, dynamic> json) => MainTask(
        uid: json['uid'],
        salesManagerId: json['sales_manager_id'],
        processingManagerId: json['processing_manager_id'],
        harvestManagerId: json['harvest_manager_id'],
        targetKilosToSale: (json['target_kilos_to_sale'] as num).toInt(),
        priority: json['priority'],
        destination: json['destination'],
        status: json['status'],
        salesManager: User.fromJson(json['sales_manager']),
        processingManager: User.fromJson(json['processing_manager']),
        harvestManager: User.fromJson(json['harvest_manager']),
      );
}
