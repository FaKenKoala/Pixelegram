import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pixelegram/infrastructure/tdapi.dart' as td;
import 'package:pixelegram/presentation/chat/chat_list_tile_content.dart';
import '../custom_widget/custom_widget.dart';
import 'package:pixelegram/infrastructure/util.dart';

class ChatTile extends StatelessWidget {
  final td.Chat chat;

  const ChatTile({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? time = chat.lastMessage?.date;
    print('时间: $time');
    String dateTime = '';
    if (time != null) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(time*1000).format();
    }

    int unreadCount = chat.unreadCount ?? 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Container(
            height: 60,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleImage(
                image: FileImage(File('')),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ChatListTileContent(
                        chat: chat,
                      ),
                    ]),
              ),
              SizedBox(
                width: 4,
              ),
              Column(
                children: [
                  Text(
                    dateTime,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Visibility(
                    visible: unreadCount != 0,
                    child: Expanded(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(16)),
                          child: Text(
                            '$unreadCount',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ]),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(height: 1, indent: 68),
        ],
      ),
    );
  }
}
