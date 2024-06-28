import 'package:json_annotation/json_annotation.dart';

part 'create_new_proc_task_req.g.dart';

@JsonSerializable()
class CreateNewProcTaskReq {
  @JsonKey(name: 'processing_operator')
  String processingOperator;
  @JsonKey(name: 'destination')
  String destination;
  @JsonKey(name: 'priority')
  int priority;

  CreateNewProcTaskReq({required this.processingOperator, required this.destination,
    required this.priority,
  });

  factory CreateNewProcTaskReq.fromJson(Map<String, dynamic> json) =>
      _$CreateNewProcTaskReqFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNewProcTaskReqToJson(this);
}