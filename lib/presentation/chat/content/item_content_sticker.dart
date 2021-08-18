import 'package:flutter/material.dart';
import 'package:pixelegram/domain/model/tdapi.dart' show MessageSticker;

class ItemContentSticker extends StatelessWidget {
  final MessageSticker sticker;
  const ItemContentSticker({Key? key, required this.sticker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('sticker内容: ${sticker.sticker!.toJson()}');
    return Text(
      '${sticker.sticker!.emoji!} Sticker',
    );
  }
}
