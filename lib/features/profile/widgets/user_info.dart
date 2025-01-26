import 'package:flutter/material.dart';
import 'package:tiberium_crm/data/models/role_enum.dart';
import 'package:tiberium_crm/features/profile/widgets/avatar.dart';
import 'package:tiberium_crm/features/profile/widgets/info_body.dart';
import '../../../data/models/user.dart';

class UserInfo extends StatelessWidget {
  final User user;
  const UserInfo(
    this.user, {
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
            child: Avatar(user.photoLink),
          ),
          const SizedBox(width: 16),
          InfoBody(
            fio: user.firstName,
            role: user.role.toStringX(),
            id: user.uid,
          ),
        ],
      );
}
