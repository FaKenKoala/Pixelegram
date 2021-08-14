import 'package:flutter/material.dart';
import 'package:pixelegram/infrastructure/tdapi.dart' show MessageSticker;

class MessageContentSticker extends StatelessWidget {
  final MessageSticker sticker;
  const MessageContentSticker({Key? key, required this.sticker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${sticker.sticker!.emoji!} Sticker',
    );
  }
}
