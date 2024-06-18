import 'package:json_annotation/json_annotation.dart';

part 'sms_login_req.g.dart';

@JsonSerializable()
class SmsLoginReq {
  @JsonKey(name: 'phone_number')
  String phoneNumber;
  @JsonKey(name: 'sms_code')
  String smsCode;

  SmsLoginReq({required this.phoneNumber, required this.smsCode});

    factory SmsLoginReq.fromJson(Map<String, dynamic> json) => _$SmsLoginReqFromJson(json);

  Map<String, dynamic> toJson() => _$SmsLoginReqToJson(this);
}