import 'package:flutter/material.dart';

class SendWidgets extends StatefulWidget {
  const SendWidgets({Key? key}) : super(key: key);

  @override
  _SendWidgetsState createState() => _SendWidgetsState();
}

class _SendWidgetsState extends State<SendWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.black38,
      padding: const EdgeInsets.only(left: 0,top: 0,right: 10,bottom: 5),
      child: Column(
        children: [
          Row(
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
        ],
      ),
    );
  }
}
