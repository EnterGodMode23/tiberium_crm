// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_new_task_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNewTaskReq _$CreateNewTaskReqFromJson(Map<String, dynamic> json) =>
    CreateNewTaskReq(
      harvestOperator: json['harvest_operator'] as String,
      destination: json['destination'] as String,
      priority: (json['priority'] as num).toInt(),
    );

Map<String, dynamic> _$CreateNewTaskReqToJson(CreateNewTaskReq instance) =>
    <String, dynamic>{
      'harvest_operator': instance.harvestOperator,
      'destination': instance.destination,
      'priority': instance.priority,
    };
