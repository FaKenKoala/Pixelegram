import 'package:flutter/material.dart';
import 'package:pixelegram/domain/model/tdapi.dart' hide Text;

class MessageContentText extends StatelessWidget {
  final MessageText content;
  const MessageContentText({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = content.text?.text ?? '';
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 62, 105, 151),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text('$text',
            style: TextStyle(
              fontSize: 18,
            )),
      ),
    );
  }
}
