import 'package:flutter/material.dart';
import 'package:model_tdapi/tdapi/tdapi.dart' as td;
import 'package:pixelegram/domain/service/i_telegram_service.dart';
import 'package:pixelegram/infrastructure/get_it/main.dart';
import 'package:pixelegram/presentation/custom_widget/custom_widget.dart';

class SenderAvatar extends StatelessWidget {
  final td.MessageSender? sender;
  const SenderAvatar({Key? key, required this.sender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ITelegramService service = getIt<ITelegramService>();
    int? userId;
    String? path;
    if (sender is td.MessageSenderUser) {
      userId = (sender as td.MessageSenderUser).userId;
      path = service.getUserAvatar(userId);
    }
    return CircleFileImage(
        filePath: path,
        width: 40,
        height: 40,
        fontSize: 20,
        text: service.getUsername(userId));
  }
}
