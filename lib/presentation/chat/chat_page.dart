import 'dart:async';

import 'package:flutter/material.dart';
import 'package:model_tdapi/model_tdapi.dart' hide Text;
import 'package:pixelegram/domain/service/i_telegram_service.dart';
import 'package:pixelegram/infrastructure/get_it/main.dart';
import 'package:pixelegram/presentation/chat/content/content.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;
  const ChatPage({Key? key, required this.chat}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [];
  Stream<Message>? messageStream;
  @override
  void initState() {
    super.initState();
    messageStream = getIt<ITelegramService>().messageStream();
  }

  @override
  void dispose() {
    messageStream = null;
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
                    MessageContent? content = messages[index].content;
                    String text = '';
                    if (content is MessageText) {
                      text = content.text!.text!;
                    }
                    return MessageContentText(
                      content: content as MessageText,
                    );
                  },
                  itemCount: messages.length,
                );
              },
            ),
          ),
          Container(
            height: 100,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(child: TextField()),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                    color: Colors.blueAccent,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
