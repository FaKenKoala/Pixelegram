import 'package:flutter/material.dart';
import 'package:pixelegram/domain/model/tdapi.dart' hide Text;

class ItemContentText extends StatelessWidget {
  final MessageText text;
  const ItemContentText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String textStr = text.text?.text ?? '';
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 62, 105, 151),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text('$textStr',
            style: TextStyle(
              fontSize: 18,
            )),
      ),
    );
  }
}
