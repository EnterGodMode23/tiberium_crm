// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_new_proc_task_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNewProcTaskReq _$CreateNewProcTaskReqFromJson(
        Map<String, dynamic> json) =>
    CreateNewProcTaskReq(
      processingOperator: json['processing_operator'] as String,
      destination: json['destination'] as String,
      priority: (json['priority'] as num).toInt(),
    );

Map<String, dynamic> _$CreateNewProcTaskReqToJson(
        CreateNewProcTaskReq instance) =>
    <String, dynamic>{
      'processing_operator': instance.processingOperator,
      'destination': instance.destination,
      'priority': instance.priority,
    };
