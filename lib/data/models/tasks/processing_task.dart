import 'package:tiberium_crm/data/models/user.dart';

class ProcessingTask {
  String? uid;
  String? created;
  String? updated;
  User? processingOperator;
  User? processingManager;
  double? processedKilos;
  String? status;
  int? priority;
  String? destination;
  String? mainTaskRef;
  String? harvestTask;

  ProcessingTask({
    this.uid,
    this.created,
    this.updated,
    this.processingOperator,
    this.processingManager,
    this.processedKilos,
    this.priority,
    this.status,
    this.mainTaskRef,
    this.destination,
    this.harvestTask,
  });

  factory ProcessingTask.fromJson(Map<String, dynamic> json) => ProcessingTask(
        uid: json['uid'],
        created: json['created'],
        updated: json['updated'],
        processingOperator: json['processing_operator'] != null
            ? User.fromJson(json['processing_operator'])
            : null,
        processingManager: User.fromJson(json['processing_manager']),
        processedKilos: json['processed_kilos'],
        priority: json['priority'],
        status: json['status'],
        mainTaskRef: json['main_task_ref'],
        destination: json['destination'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['created'] = created;
    data['updated'] = updated;
    data['processing_operator'] = processingOperator;
    data['processing_manager'] = processingManager;
    data['processed_kilos'] = processedKilos;
    data['priority'] = priority;
    data['status'] = status;
    data['destination'] = destination;
    data['main_task_ref'] = mainTaskRef;
    data['harvest_task'] = harvestTask;
    return data;
  }
}
