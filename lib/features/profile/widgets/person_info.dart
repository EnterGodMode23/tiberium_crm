import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiberium_crm/data/models/person.dart';

class PersonInfo extends StatefulWidget {
  final Person person;
  const PersonInfo(
    this.person, {
    super.key,
  });

  @override
  State<PersonInfo> createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> {
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
            child: _getAvatar(widget.person.photoLink)),
        const SizedBox(width: 16),
        _getBody(widget.person),
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
          imageUrl: widget.person.photoLink,
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

  Widget _getBody(Person person) {
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
                person.fio,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                person.role.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                person.id,
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
