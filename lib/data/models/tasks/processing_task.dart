import 'package:tiberium_crm/data/models/user.dart';
import 'package:tiberium_crm/data/task_type.dart';

class ProcessingTask{
  String? uid;
  String? created;
  String? updated;
  User? processingOperator;
  User? processingManager;
  num? processedKilos;
  TaskStatus? status;
  int? priority;
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
    this.harvestTask,
  });

  ProcessingTask.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    created = json['created'];
    updated = json['updated'];
    processingOperator = json['processing_operator'];
    processingManager = json['processing_manager'];
    processedKilos = json['processed_kilos'];
    priority = json['priority'];
    status = json['status'];
    mainTaskRef = json['main_task_ref'];
    harvestTask = json['harvest_task'];
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
    data['main_task_ref'] = mainTaskRef;
    data['harvest_task'] = harvestTask;
    return data;
  }
}