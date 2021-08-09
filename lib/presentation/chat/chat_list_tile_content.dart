import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pixelegram/application/telegram_service.dart';
import 'package:pixelegram/infrastructure/tdapi.dart' as td;
import 'package:collection/collection.dart';

class ChatListTileContent extends StatelessWidget {
  final td.Chat chat;

  const ChatListTileContent({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chat.type is td.ChatTypePrivate
        ? PrivateChatContent(chat: chat)
        : GroupChatContent(chat: chat);
  }
}

class PrivateChatContent extends StatelessWidget {
  final td.Chat chat;

  const PrivateChatContent({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    td.MessageContent? content = chat.lastMessage?.content;

    String? text;
    if (content != null) {
      if (content is td.MessageText) text = content.text?.text ?? '';
    }
    return Text(
      text ?? '',
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 14, color: Colors.grey),
      maxLines: 2,
    );
  }
}

class GroupChatContent extends StatelessWidget {
  final td.Chat chat;

  const GroupChatContent({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = "";
    String? senderName;
    td.MessageSender? sender = chat.lastMessage?.sender;
    if (sender is td.MessageSenderUser) {
      senderName = GetIt.I<TelegramService>()
              .users
              .firstWhereOrNull((element) => element.id == sender.userId)
              ?.firstName ??
          '';
    }
    td.MessageContent? content = chat.lastMessage?.content;

    if (content != null) {
      if (content is td.MessageText) text = content.text?.text ?? '';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (senderName != null)
          Text(senderName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: Colors.white),
              maxLines: 1),
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14, color: Colors.grey),
          maxLines: 1,
        ),
      ],
    );
  }
}
