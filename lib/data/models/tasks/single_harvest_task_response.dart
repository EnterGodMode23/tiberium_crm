import 'package:tiberium_crm/data/models/tasks/harvest_task.dart';

class SingleHarvestTaskResponse {
  final HarvestTask data;

  SingleHarvestTaskResponse({
    required this.data,
  });

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
      };

  factory SingleHarvestTaskResponse.fromJson(Map<String, dynamic> json) =>
      SingleHarvestTaskResponse(
        data: HarvestTask.fromJson(json['data'] as Map<String, dynamic>),
      );
}
