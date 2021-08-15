import 'package:flutter/material.dart';
import 'package:pixelegram/domain/model/tdapi.dart' as td;

class MessageContentAudio extends StatelessWidget {
  final td.MessageAudio audio;

  const MessageContentAudio({Key? key, required this.audio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? text = audio.caption?.text;
    if (text == null) {
      String artist = audio.audio?.performer ?? '';
      if (artist.isEmpty) {
        artist = 'Unknown artist';
      }
      String name = audio.audio?.fileName ?? '';
      text = '$artist - $name';
    }
    return Row(
      children: [
        Icon(
          Icons.audiotrack,
          color: Colors.grey,
          size: 18,
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
            child: Text(
          '$text',
          overflow: TextOverflow.ellipsis,
        )),
      ],
    );
  }
}
