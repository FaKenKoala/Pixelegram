import 'package:flutter/material.dart';
import 'package:pixelegram/domain/tdapi/tdapi.dart' show Chat;

class ChatPage extends StatefulWidget {
  final Chat chat;
  const ChatPage({Key? key, required this.chat}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('${widget.chat.title ?? 'Chat'}'),
      ),
      body: Center(
        child: Text('聊天内容'),
      ),
    );
  }
}
