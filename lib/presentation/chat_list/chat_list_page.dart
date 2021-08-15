import 'package:flutter/material.dart';
import 'package:pixelegram/domain/service/i_telegram_service.dart';
import 'package:pixelegram/domain/model/tdapi.dart' as td;
import 'package:pixelegram/infrastructure/get_it/main.dart';
import 'list_tile/chat_list_tile.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late Stream<int> chatsStream;

  @override
  void initState() {
    super.initState();
    chatsStream = getIt<ITelegramService>().chatsStream();
    _getChats();
  }

  _getChats() {
    getIt<ITelegramService>().getChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(
        stream: chatsStream,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<td.Chat> chats = getIt<ITelegramService>().chats;
          return ListView.builder(
            itemBuilder: (_, pos) => ChatListTile(chat: chats[pos]),
            itemCount: chats.length,
          );
        },
      ),
    );
  }
}
