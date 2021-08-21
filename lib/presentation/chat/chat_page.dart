import 'dart:async';

import 'package:flutter/material.dart';
import 'package:model_tdapi/model_tdapi.dart' hide Text;
import 'package:pixelegram/domain/model/p_message.dart';
import 'package:pixelegram/domain/service/i_telegram_service.dart';
import 'package:pixelegram/infrastructure/get_it/main.dart';
import 'package:pixelegram/presentation/chat/chat_item_content.dart';
import 'package:pixelegram/presentation/chat/widgets/send_widgets.dart';
import 'package:time/time.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;

  const ChatPage({Key? key, required this.chat}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<PMessage> messages = [];
  Stream<Message>? messageStream;
  Stream<int>? chatStream;
  late StreamSubscription subscription;
  late ITelegramService service;
  int firstHistoryCount = 2;
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    service = getIt<ITelegramService>();
    messageStream = service.messageStream(widget.chat.id!);
    chatStream = service.chatsStream();
    subscription = service.historyStream().listen((List<Message> msgs) {
      setState(() {
        Set<PMessage> sets = this.messages.toSet()
          ..addAll(msgs.map((e) => PMessage(e)));
        messages = (sets.toList()..sort());

        if (firstHistoryCount <= 0) return;

        firstHistoryCount--;

        if (firstHistoryCount > 0) {
          if (msgs.length < 20)
            getHistory();
          else
            firstHistoryCount = 0;
        }

        if (firstHistoryCount >= 0)
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Future.delayed(10.milliseconds, () {
              controller.jumpTo(controller.position.maxScrollExtent);
            });
          });
      });
    });
    getHistory();
  }

  void getHistory([int fromMessageId = 0]) {
    service.getChatHistory(
        chatId: widget.chat.id!, fromMessageId: fromMessageId);
  }

  @override
  void dispose() {
    controller.dispose();
    messageStream = null;
    chatStream = null;
    subscription.cancel();
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
                  messages = (this.messages.toSet()
                        ..add(PMessage(snapshot.data!)))
                      .toList()
                        ..sort();
                }
                return ListView.builder(
                  controller: controller,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (_, index) {
                    return StreamBuilder<int>(
                        stream: chatStream,
                        builder: (context, snapshot) {
                          print('新值进入');
                          return ChatItemContent(
                              message: messages[index].message);
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
