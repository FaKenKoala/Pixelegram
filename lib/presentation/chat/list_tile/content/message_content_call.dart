import 'package:flutter/material.dart';
import 'package:pixelegram/infrastructure/tdapi.dart' as td;
import 'package:pixelegram/infrastructure/util.dart';

class MessageContentCall extends StatelessWidget {
  final td.MessageCall call;

  const MessageContentCall({Key? key, required this.call}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String discardReason = call.discardReason == null ||
            call.discardReason is td.CallDiscardReasonEmpty
        ? 'End'
        : call.discardReason!
            .getConstructor()
            .replaceAll('callDiscardReason', '');
    discardReason += ' Call';
    return Text(
      discardReason,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
