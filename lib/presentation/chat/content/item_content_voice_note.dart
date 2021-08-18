import 'package:flutter/material.dart';
import 'package:pixelegram/domain/model/tdapi.dart' as td;
import 'package:pixelegram/infrastructure/util/util.dart';

class ItemContentVoiceNote extends StatelessWidget {
  final td.MessageVoiceNote voiceNote;

  const ItemContentVoiceNote({Key? key, required this.voiceNote})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = voiceNote.caption?.text ?? 'Voice Message';
    return Row(
      children: [
        Icon(
          Icons.keyboard_voice,
          color: Colors.grey,
          size: 18,
        ),
        SizedBox(
          width: 4,
        ),
        Text('$name (${TimeUtil.ms(voiceNote.voiceNote?.duration ?? 0)})'),
      ],
    );
  }
}
