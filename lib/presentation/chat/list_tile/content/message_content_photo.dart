import 'package:flutter/material.dart';
import 'package:pixelegram/infrastructure/tdapi.dart' as td;
import 'package:pixelegram/presentation/custom_widget/custom_widget.dart';
import 'package:pixelegram/infrastructure/util.dart';
class MessageContentPhoto extends StatelessWidget {
  final td.MessagePhoto photo;

  const MessageContentPhoto({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    td.Minithumbnail? thumbnail = photo.photo?.minithumbnail;
    String? data = thumbnail?.data;
    String name = photo.caption?.text?.replaceNewLines() ?? 'Photo';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (data != null) Base64Image(base64Str: data),
        if (data != null)
          SizedBox(
            width: 4,
          ),
        Expanded(
            child: Text(
          '$name',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ))
      ],
    );
  }
}
