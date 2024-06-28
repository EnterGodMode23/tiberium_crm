import 'package:tiberium_crm/data/models/user.dart';

class ProcessingTask {
  String? uid;
  String? created;
  String? updated;
  User? processingOperator;
  User? processingManager;
  num? processedKilos;
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

  ProcessingTask.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      uid = json['data']['uid'];
      created = json['data']['created'];
      updated = json['data']['updated'];
      processingOperator = User(firstName: 'Process', lastName: 'Test');
      processingManager = null;
      processedKilos = json['data']['processed_kilos'];
      priority = json['data']['priority'];
      status = json['data']['status'];
      mainTaskRef = json['data']['main_task_ref'];
      destination = json['data']['destination'];
      harvestTask = json['data']['harvest_task'];
    } else {
      uid = json['uid'];
      created = json['created'];
      updated = json['updated'];
      try {
        processingOperator = User.fromJson(json['processing_operator']);
        processingManager = User.fromJson(json['processing_manager']);
      } catch (e) {
        processingOperator = User(firstName: 'Process', lastName: 'Test');
        processingManager = null;
      }
      processedKilos = json['processed_kilos'];
      priority = json['priority'];
      status = json['status'];
      mainTaskRef = json['main_task_ref'];
      destination = json['destination'];
      harvestTask = json['harvest_task'];
    }
  }

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
