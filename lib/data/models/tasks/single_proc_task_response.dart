import 'package:tiberium_crm/data/models/tasks/processing_task.dart';

class SingleProcessingTaskResponse {
  final ProcessingTask data;

  SingleProcessingTaskResponse({required this.data});

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
      };

  factory SingleProcessingTaskResponse.fromJson(Map<String, dynamic> json) =>
      SingleProcessingTaskResponse(
        data: ProcessingTask.fromJson(json['data'] as Map<String, dynamic>),
      );
}
