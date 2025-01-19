import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiberium_crm/features/app/routing/app_router.dart';
import 'package:tiberium_crm/features/profile/widgets/profile_button.dart';
import 'package:tiberium_crm/features/profile/widgets/user_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/user.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final User user;

  final localStorage = GetIt.I<SharedPreferences>();

  @override
  void initState() {
    user = User.fromJson(
      jsonDecode(localStorage.getString('user')!),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
              localStorage.clear();
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
              child: UserInfo(user),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const InkWell(
                    onTap: _launchPhoneCall,
                    child: ProfileButton(
                      'Support',
                      'assets/support_icon.svg',
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {},
                    child: const ProfileButton(
                      'Language',
                      'assets/language_icon.svg',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

Future<void> _launchPhoneCall() async {
  if (!await launchUrl(
    Uri(
      scheme: 'tel',
      path: '+79999999999',
    ),
  )) {
    throw Exception('Could not launch phone call');
  }
}
