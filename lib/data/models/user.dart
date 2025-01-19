class User {
  String uid;
  String? created;
  String? updated;
  String phoneNumber;
  bool? deactivated;
  String? email;
  String role;
  String firstName;
  String lastName;
  String? photoLink;

  User({
    required this.uid,
    this.created,
    this.updated,
    required this.phoneNumber,
    this.deactivated,
    this.email,
    required this.role,
    required this.firstName,
    required this.lastName,
    this.photoLink = '',
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json['uid'],
        created: json['created'],
        updated: json['updated'],
        phoneNumber: json['phone_number'],
        deactivated: json['deactivated'],
        email: json['email'],
        role: json['role'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        photoLink: json['photo_link'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'created': created,
        'updated': updated,
        'phone_number': phoneNumber,
        'deactivated': deactivated,
        'email': email,
        'role': role,
        'first_name': firstName,
        'last_name': lastName,
        'photo_link': photoLink,
      };
}
