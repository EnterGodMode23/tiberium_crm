import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:tiberium_crm/data/models/person.dart';
import 'package:tiberium_crm/data/user_role.dart';
import 'package:tiberium_crm/features/profile/widgets/person_info.dart';
import 'package:tiberium_crm/features/profile/widgets/profile_button.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Profile',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: InkWell(
          onTap: () {},
          child: const Center(
            child: Text(
              'Log out',
              style: TextStyle(
                fontFamily: 'SFUI',
                fontSize: 44,
                fontWeight: FontWeight.w400,
                color: Color(0xFFFE7171),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: PersonInfo(
              Person(
                fio: 'Ivan Ivanov',
                role: UserRole.harvesterOperator,
                photoLink: '',
                id: '1488',
              ),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: ProfileButton('Support', 'assets/support_icon.svg'),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {},
                  child: ProfileButton('Language', 'assets/language_icon.svg'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
