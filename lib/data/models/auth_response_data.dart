import 'package:tiberium_crm/data/models/user.dart';

class AuthResponseData {
  User? user;
  bool? firstAuth;
  String? accessToken;
  String? refreshToken;

  AuthResponseData({this.user, this.firstAuth, this.accessToken, this.refreshToken});

  AuthResponseData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    firstAuth = json['first_auth'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['first_auth'] = firstAuth;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }
}