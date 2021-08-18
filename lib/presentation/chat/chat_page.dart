import 'dart:async';

import 'package:flutter/material.dart';
import 'package:model_tdapi/model_tdapi.dart' hide Text;
import 'package:pixelegram/domain/service/i_telegram_service.dart';
import 'package:pixelegram/infrastructure/get_it/main.dart';
import 'package:pixelegram/presentation/chat/chat_item_content.dart';
import 'package:pixelegram/presentation/chat/content/content.dart';
import 'package:pixelegram/presentation/chat/widgets/send_widgets.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;
  const ChatPage({Key? key, required this.chat}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [];
  Stream<Message>? messageStream;
  Stream<int>? chatStream;
  @override
  void initState() {
    super.initState();
    messageStream = getIt<ITelegramService>().messageStream(widget.chat.id!);
    chatStream = getIt<ITelegramService>().chatsStream();
  }

  @override
  void dispose() {
    messageStream = null;
    chatStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('${widget.chat.title ?? 'Chat'}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<Message>(
              stream: messageStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  messages.add(snapshot.data!);
                }
                return ListView.builder(
                  itemBuilder: (_, index) {
                    return StreamBuilder<int>(
                        stream: chatStream,
                        builder: (context, snapshot) {
                          return ChatItemContent(message: messages[index]);
                        });
                  },
                  itemCount: messages.length,
                );
              },
            ),
          ),
          SendWidgets(),
        ],
      ),
    );
  }
}
