import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:pixelegram/application/telegram_service.dart';

class AuthCodePage extends StatefulWidget {
  const AuthCodePage({Key? key}) : super(key: key);

  @override
  _AuthCodePageState createState() => _AuthCodePageState();
}

class _AuthCodePageState extends State<AuthCodePage> {
  TextEditingController _editingController = TextEditingController();
  bool isSending = false;
  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _editingController,
            decoration:
                InputDecoration(labelText: 'Code', border: OutlineInputBorder()),
            textInputAction: TextInputAction.send,
            onSubmitted: (String code) {},
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            sendCode();
          },
          child: !isSending
              ? Icon(Icons.forward, color: Colors.white)
              : SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(color: Colors.white))),
    );
  }

  sendCode() {
    if (isSending) {
      return;
    }
    String code = _editingController.text.trim();
    if (code.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Please Enter Your Phone Number', gravity: ToastGravity.CENTER);
      return;
    }

    setState(() {
      isSending = !isSending;
    });
    GetIt.I<TelegramService>().checkAuthenticationCode(code);
  }
}
