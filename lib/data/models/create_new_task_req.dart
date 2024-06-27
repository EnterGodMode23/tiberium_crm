import 'package:json_annotation/json_annotation.dart';

part 'create_new_task_req.g.dart';

@JsonSerializable()
class CreateNewTaskReq {
  @JsonKey(name: 'harvest_operator')
  String harvestOperator;
  @JsonKey(name: 'destination')
  String destination;
  @JsonKey(name: 'priority')
  int priority;
  // @JsonKey(name: 'target_kilos_to_harvest')
  // int targetKilosToHarvest;
  // @JsonKey(name: 'status')
  // String status;
  // @JsonKey(name: 'main_task_ref')
  // String status;

  CreateNewTaskReq({required this.harvestOperator, required this.destination,
    required this.priority,
    //required this.targetKilosToHarvest,
    //required this.status,
  });

  factory CreateNewTaskReq.fromJson(Map<String, dynamic> json) =>
      _$CreateNewTaskReqFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNewTaskReqToJson(this);
}