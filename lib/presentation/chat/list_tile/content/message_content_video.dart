import 'package:flutter/material.dart';
import 'package:pixelegram/domain/model/tdapi.dart' as td;
import 'package:pixelegram/presentation/custom_widget/custom_widget.dart';
import 'package:pixelegram/infrastructure/util/util.dart';

class MessageContentVideo extends StatelessWidget {
  final td.MessageVideo video;

  const MessageContentVideo({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    td.Minithumbnail? thumbnail = video.video?.minithumbnail;
    String? data = thumbnail?.data;
    String name = video.caption?.text?.replaceNewLines() ?? 'Video';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (data != null)
          Base64Image(
            base64Str: data,
            childBuilder: (_) => Center(
              child: Icon(
                Icons.play_arrow_sharp,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        if (data != null)
          SizedBox(
            width: 4,
          ),
        Expanded(
            child: Text(
          '$name',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ))
      ],
    );
  }
}
