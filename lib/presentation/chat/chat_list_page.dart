import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pixelegram/application/telegram_service.dart';
import 'package:pixelegram/infrastructure/tdapi.dart' as td;
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
    chatsStream = GetIt.I<TelegramService>().chatsStream();
    _getChats();
  }

  _getChats() {
    GetIt.I<TelegramService>().getChats();
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
          List<td.Chat> chats = GetIt.I<TelegramService>().chats;
          return ListView.builder(
            itemBuilder: (_, pos) => ChatListTile(chat: chats[pos]),
            itemCount: chats.length,
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'refresh',
            onPressed: () {
              _getChats();
            },
            child: Icon(
              Icons.refresh_outlined,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: 'logout',
            onPressed: () async {},
            child: Icon(Icons.logout, color: Colors.white),
          )
        ],
      ),
    );
  }
}
