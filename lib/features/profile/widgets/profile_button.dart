import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileButton extends StatelessWidget {
  final String iconPath;
  final String title;
  const ProfileButton(this.title, this.iconPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconPath),
        const SizedBox(width: 10),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'SFUI',
            fontSize: 44,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
