import 'package:flutter/material.dart';
import 'package:pixelegram/domain/tdapi/tdapi.dart' as td;

class MessageContentDocument extends StatelessWidget {
  final td.MessageDocument document;

  const MessageContentDocument({Key? key, required this.document})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = document.caption?.text ?? document.document?.fileName ?? '';
    return Row(
      children: [
        Icon(
          Icons.insert_drive_file,
          color: Colors.grey,
          size: 18,
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
            child: Text(
          '$name',
          overflow: TextOverflow.ellipsis,
        )),
      ],
    );
  }
}
