import 'package:tiberium_crm/data/models/tasks/harvest_task.dart';

class HarvestTaskList {
  List<HarvestTask>? harvestTasks;

  HarvestTaskList({this.harvestTasks});

  HarvestTaskList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      harvestTasks = <HarvestTask>[];
      json['data'].forEach((v) {
        harvestTasks!.add(HarvestTask.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (harvestTasks != null) {
      data['data'] = harvestTasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
