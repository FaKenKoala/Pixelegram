import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pixelegram/application/router/router.dart';
import 'package:pixelegram/application/get_it/get_it.dart';
import 'package:pixelegram/domain/service/i_telegram_service.dart';
import 'package:pixelegram/domain/tdapi/tdapi.dart' as td;
import 'package:pixelegram/infrastructure/get_it/main.dart';
import 'package:pixelegram/presentation/chat/list_tile/chat_list_tile_content.dart';
import '../../custom_widget/custom_widget.dart';
import 'package:pixelegram/infrastructure/util.dart';
import 'package:collection/collection.dart';

class ChatListTile extends StatelessWidget {
  final td.Chat chat;

  const ChatListTile({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? time = chat.lastMessage?.date;
    String dateTime = '';
    if (time != null) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000).format();
    }
    td.File? photo = chat.photo?.small;
    String? path = getIt<ITelegramService>().getLocalFile(photo?.id);

    return InkWell(
      onTap: () {
        GetIt.I<AppRouter>().navigate(ChatPageRoute(chat: chat));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              height: 64,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CircleFileImage(
                  filePath: path,
                  text: photo?.id == null
                      ? chat.title?.trim().substring(0, 1)
                      : null,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${chat.title ?? ''}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorsWhite90,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              dateTime,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: chat.type is td.ChatTypePrivate
                                    ? PrivateChatListTile(chat: chat)
                                    : GroupChatListTile(chat: chat),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Visibility(
                                visible: (chat.unreadCount ?? 0) != 0,
                                child: UnreadCountWidget(
                                  unreadCount: chat.unreadCount,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ]),
            ),
            Divider(
              height: 1,
              indent: 68,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

/// PrivateChat
class PrivateChatListTile extends StatelessWidget {
  final td.Chat chat;

  const PrivateChatListTile({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileMessageContent(
      message: chat.lastMessage,
      chatType: chat.type!,
    );
  }
}

/// GroupChatTile
class GroupChatListTile extends StatelessWidget {
  final td.Chat chat;

  const GroupChatListTile({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? senderName;
    td.MessageSender? sender = chat.lastMessage?.sender;
    if (sender is td.MessageSenderUser) {
      td.User? me = getIt<ITelegramService>().me;

      td.User? user = getIt<ITelegramService>()
          .users
          .firstWhereOrNull((element) => element.id == sender.userId);
      if (user != null && me != null && user.id == me.id) {
        senderName = 'You';
      } else {
        senderName = user?.firstName ?? '';
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (senderName != null)
          Text(senderName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: ColorsWhite90),
              maxLines: 1),
        if (senderName != null)
          SizedBox(
            height: 2,
          ),
        ListTileMessageContent(
          message: chat.lastMessage,
          chatType: chat.type!,
        ),
      ],
    );
  }
}
