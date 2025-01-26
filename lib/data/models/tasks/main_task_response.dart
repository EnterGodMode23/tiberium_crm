import 'package:tiberium_crm/data/models/tasks/main_task.dart';

class MainTaskResponse {
  final List<MainTask> data;

  MainTaskResponse({required this.data});

  Map<String, dynamic> toJson() => {
        'data': data.map((task) => task.toJson()).toList(),
      };

  factory MainTaskResponse.fromJson(Map<String, dynamic> json) =>
      MainTaskResponse(
        data: (json['data'] as List<dynamic>)
            .map((task) => MainTask.fromJson(task as Map<String, dynamic>))
            .toList(),
      );
}
