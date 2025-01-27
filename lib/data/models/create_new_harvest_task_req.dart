import 'package:json_annotation/json_annotation.dart';

part 'create_new_harvest_task_req.g.dart';

@JsonSerializable()
class CreateNewHarvestTaskReq {
  @JsonKey(name: 'harvest_operator_id')
  String harvestOperator;
  @JsonKey(name: 'destination')
  String destination;
  @JsonKey(name: 'priority')
  int priority;
  @JsonKey(name: 'main_task_ref')
  String mainTaskRef;
  @JsonKey(name: 'target_kilos_to_harvest')
  double killos;
  String status;

  CreateNewHarvestTaskReq({
    required this.harvestOperator,
    required this.destination,
    required this.priority,
    required this.mainTaskRef,
    required this.killos,
    required this.status,
  });

  factory CreateNewHarvestTaskReq.fromJson(Map<String, dynamic> json) =>
      _$CreateNewHarvestTaskReqFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNewHarvestTaskReqToJson(this);
}
