import 'package:flutter/material.dart';
import 'package:pixelegram/domain/tdapi/tdapi.dart' as td;
import 'package:pixelegram/infrastructure/util.dart';

class MessageContentVideoNote extends StatelessWidget {
  final td.MessageVideoNote videoNote;

  const MessageContentVideoNote({Key? key, required this.videoNote})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.camera_alt_sharp,
          color: Colors.grey,
          size: 18,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
            'Video Message (${TimeUtil.ms(videoNote.videoNote?.duration ?? 0)})'),
      ],
    );
  }
}
