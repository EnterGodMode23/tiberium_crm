// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_new_harvest_task_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNewHarvestTaskReq _$CreateNewHarvestTaskReqFromJson(
        Map<String, dynamic> json) =>
    CreateNewHarvestTaskReq(
      processingOperator: json['harvest_operator_id'] as String,
      destination: json['destination'] as String,
      priority: (json['priority'] as num).toInt(),
      mainTaskRef: json['main_task_ref'] as String,
      killos: (json['target_kilos_to_harvest'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$CreateNewHarvestTaskReqToJson(
        CreateNewHarvestTaskReq instance) =>
    <String, dynamic>{
      'harvest_operator_id': instance.processingOperator,
      'destination': instance.destination,
      'priority': instance.priority,
      'main_task_ref': instance.mainTaskRef,
      'target_kilos_to_harvest': instance.killos,
      'status': instance.status,
    };
