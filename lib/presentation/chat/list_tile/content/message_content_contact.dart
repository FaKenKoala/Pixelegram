import 'package:flutter/material.dart';
import 'package:pixelegram/infrastructure/tdapi.dart' as td;

class MessageContentContact extends StatelessWidget {
  final td.MessageContact contact;

  const MessageContentContact({Key? key, required this.contact})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.person_sharp,
          color: Colors.grey,
          size: 18,
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
            child: Text(
          contact.contact?.firstName ?? '',
          overflow: TextOverflow.ellipsis,
        )),
      ],
    );
  }
}
