import 'package:flutter/material.dart';
import 'package:pixelegram/domain/model/tdapi.dart' as td;

class ItemContentPoll extends StatelessWidget {
  final td.MessagePoll poll;

  const ItemContentPoll({Key? key, required this.poll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.poll,
          color: Colors.grey,
          size: 18,
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
            child: Text(
          '${poll.poll?.question ?? ''}',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        )),
      ],
    );
  }
}
