import 'package:tiberium_crm/data/models/user.dart';

class UsersList {
  List<User>? users;

  UsersList({this.users});

  UsersList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      users = <User>[];
      json['data'].forEach((v) {
        users!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (users != null) {
      data['data'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
