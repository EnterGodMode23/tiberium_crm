import 'package:tiberium_crm/data/models/tasks/processing_task.dart';

class ProcessingTaskList {
  List<ProcessingTask>? processingTasks;

  ProcessingTaskList({this.processingTasks});

  ProcessingTaskList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      processingTasks = <ProcessingTask>[];
      json['data'].forEach((v) {
        processingTasks!.add(ProcessingTask.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (processingTasks != null) {
      data['data'] = processingTasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
