import 'package:json_annotation/json_annotation.dart';

part 'create_new_proc_task_req.g.dart';

@JsonSerializable()
class CreateNewProcTaskReq {
  @JsonKey(name: 'harvest_task_id')
  String harvestTaskId;
  @JsonKey(name: 'processing_operator_id')
  String processingOperator;
  @JsonKey(name: 'destination')
  String destination;
  @JsonKey(name: 'priority')
  int priority;
  @JsonKey(name: 'main_task_ref')
  String mainTaskRef;
  @JsonKey(name: 'processed_kilos')
  double killos;
  String status;

  CreateNewProcTaskReq({
    required this.harvestTaskId,
    required this.processingOperator,
    required this.destination,
    required this.priority,
    required this.mainTaskRef,
    required this.killos,
    required this.status,
  });

  factory CreateNewProcTaskReq.fromJson(Map<String, dynamic> json) =>
      _$CreateNewProcTaskReqFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNewProcTaskReqToJson(this);
}
