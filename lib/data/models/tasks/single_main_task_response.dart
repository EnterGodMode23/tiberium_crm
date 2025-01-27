import 'package:tiberium_crm/data/models/tasks/main_task.dart';

class SingleMainTaskResponse {
  final MainTask data;

  SingleMainTaskResponse({required this.data});

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
      };

  factory SingleMainTaskResponse.fromJson(Map<String, dynamic> json) =>
      SingleMainTaskResponse(
        data: MainTask.fromJson(json['data'] as Map<String, dynamic>),
      );
}
