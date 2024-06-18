// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_login_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmsLoginReq _$SmsLoginReqFromJson(Map<String, dynamic> json) => SmsLoginReq(
      phoneNumber: json['phone_number'] as String,
      smsCode: json['sms_code'] as String,
    );

Map<String, dynamic> _$SmsLoginReqToJson(SmsLoginReq instance) =>
    <String, dynamic>{
      'phone_number': instance.phoneNumber,
      'sms_code': instance.smsCode,
    };
