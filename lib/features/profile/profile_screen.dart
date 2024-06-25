import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/features/profile/widgets/profile_button.dart';
import 'package:tiberium_crm/features/profile/widgets/user_info.dart';

import '../../app.dart';
import '../../data/models/user.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context){
    // TODO: get user for the whole app from home screen
    final user = User.fromJson(jsonDecode(App.localStorage.getString('user')!));
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
          onTap: () {
            App.localStorage.clear();
            AutoRouter.of(context).replaceAll([const AuthRoute()]);
          },
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
            child: UserInfo(user
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child:
                      const ProfileButton('Support', 'assets/support_icon.svg'),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {},
                  child: const ProfileButton(
                      'Language', 'assets/language_icon.svg'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
