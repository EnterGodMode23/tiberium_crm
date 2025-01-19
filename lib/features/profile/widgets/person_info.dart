import 'package:flutter/material.dart';
import 'package:tiberium_crm/data/models/person.dart';
import 'package:tiberium_crm/features/profile/widgets/avatar.dart';
import 'package:tiberium_crm/features/profile/widgets/info_body.dart';

class PersonInfo extends StatelessWidget {
  final Person person;
  const PersonInfo(
    this.person, {
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
            ),
            child: Avatar(person.photoLink),
          ),
          const SizedBox(width: 16),
          //Body(person),
        ],
      );
}
