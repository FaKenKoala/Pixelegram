import 'package:flutter/material.dart';
import 'package:pixelegram/domain/model/tdapi.dart' as td;

class MessageContentLocation extends StatelessWidget {
  final td.MessageLocation location;

  const MessageContentLocation({Key? key, required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.my_location,
          color: Colors.grey,
          size: 18,
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
            child: Text(
          'Location',
          overflow: TextOverflow.ellipsis,
        )),
      ],
    );
  }
}
