import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../data/models/user.dart';

class UserInfo extends StatefulWidget {
  final User user;
  const UserInfo(
      this.user, {
        super.key,
      });

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
            ),
            child: _getAvatar(widget.user.photoLink!)),
        const SizedBox(width: 16),
        _getBody(widget.user),
      ],
    );
  }

  Widget _getAvatar(String link) {
    if (link.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
          width: 64,
          height: 64,
          fit: BoxFit.cover,
          imageUrl: widget.user.photoLink!,
          placeholder: (context, url) => const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      );
    }
    return CircleAvatar(
      radius: 64,
      child: SvgPicture.asset('assets/avatar_placeholder.svg'),
    );
  }

  Widget _getBody(User user) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.firstName!} ${user.lastName!}',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                user.role!,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                user.uid!,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
