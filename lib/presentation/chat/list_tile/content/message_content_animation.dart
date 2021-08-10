import 'package:flutter/material.dart';
import 'package:pixelegram/infrastructure/tdapi.dart' as td;
import 'package:pixelegram/presentation/custom_widget/custom_widget.dart';


class MessageContentAnimation extends StatelessWidget {
  final td.MessageAnimation animation;

  const MessageContentAnimation({Key? key, required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    td.Minithumbnail? thumbnail = animation.animation?.minithumbnail;
    String? data = thumbnail?.data;
    return Row(
      children: [
        if (data != null)
          Base64Image(base64Str:data),
        if (data != null)
          SizedBox(
            width: 4,
          ),
        Text('GIF')
      ],
    );
  }
}
