import 'package:tiberium_crm/data/user_role.dart';

class Person {
  final String fio;
  final UserRole role;
  final String photoLink;
  final String id;

  const Person({
    required this.fio,
    required this.role,
    required this.photoLink,
    required this.id,
  });
}
