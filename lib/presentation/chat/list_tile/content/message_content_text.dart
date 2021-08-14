import 'package:flutter/material.dart';
import 'package:pixelegram/infrastructure/tdapi.dart' as td;
import 'package:pixelegram/infrastructure/util.dart';
class MessageContentText extends StatelessWidget {
  final td.ChatType chatType;

  final td.MessageText text;

  const MessageContentText(
      {Key? key, required this.chatType, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.text?.text?.replaceNewLines() ?? '',
      overflow: TextOverflow.ellipsis,
      maxLines: chatType is td.ChatTypeBasicGroup ? 1 : 2,
    );
  }
}
