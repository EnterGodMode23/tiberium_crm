// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_new_proc_task_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNewProcTaskReq _$CreateNewProcTaskReqFromJson(
        Map<String, dynamic> json) =>
    CreateNewProcTaskReq(
      harvestTaskId: json['harvest_task_id'] as String,
      processingOperator: json['processing_operator_id'] as String,
      destination: json['destination'] as String,
      priority: (json['priority'] as num).toInt(),
      mainTaskRef: json['main_task_ref'] as String,
      killos: (json['processed_kilos'] as num).toDouble(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$CreateNewProcTaskReqToJson(
        CreateNewProcTaskReq instance) =>
    <String, dynamic>{
      'harvest_task_id': instance.harvestTaskId,
      'processing_operator_id': instance.processingOperator,
      'destination': instance.destination,
      'priority': instance.priority,
      'main_task_ref': instance.mainTaskRef,
      'processed_kilos': instance.killos,
      'status': instance.status,
    };
