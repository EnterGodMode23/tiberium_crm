import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Avatar extends StatelessWidget {
  const Avatar(
    this.link, {
    super.key,
  });

  final String? link;

  @override
  Widget build(BuildContext context) => link?.isNotEmpty ?? false
      ? ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: CachedNetworkImage(
            width: 64,
            height: 64,
            fit: BoxFit.cover,
            imageUrl: link!,
            placeholder: (context, url) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        )
      : CircleAvatar(
          radius: 64,
          child: SvgPicture.asset('assets/avatar_placeholder.svg'),
        );
}
