import 'package:tiberium_crm/data/models/user.dart';

class AuthResponseData {
  final User user;
  final bool? firstAuth;
  final String accessToken;
  final String? refreshToken;

  AuthResponseData({
    required this.user,
    this.firstAuth,
    required this.accessToken,
    this.refreshToken,
  });

  AuthResponseData.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['user'] as Map<String, dynamic>),
        firstAuth = json['first_auth'],
        accessToken = json['access_token'] as String,
        refreshToken = json['refresh_token'] as String?;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user'] = user.toJson();
    data['first_auth'] = firstAuth;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }
}
