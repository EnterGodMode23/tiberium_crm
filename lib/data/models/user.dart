class User {
  String? uid;
  String? created;
  String? updated;
  String? phoneNumber;
  bool? deactivated;
  String? email;
  String? role;
  String? firstName;
  String? lastName;
  String? photoLink = '';


  User({
    this.uid,
    this.created,
    this.updated,
    this.phoneNumber,
    this.deactivated,
    this.email,
    this.role,
    this.firstName,
    this.lastName
  });

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    created = json['created'];
    updated = json['updated'];
    phoneNumber = json['phone_number'];
    deactivated = json['deactivated'];
    email = json['email'];
    role = json['role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['created'] = created;
    data['updated'] = updated;
    data['phone_number'] = phoneNumber;
    data['deactivated'] = deactivated;
    data['email'] = email;
    data['role'] = role;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
