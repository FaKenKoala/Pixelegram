import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pixelegram/domain/model/tdapi.dart' show MessageSticker;
import 'package:pixelegram/domain/service/i_telegram_service.dart';
import 'package:pixelegram/infrastructure/get_it/main.dart';
import 'package:pixelegram/infrastructure/util/util.dart';
import 'package:path/path.dart' as p;

class ItemContentSticker extends StatelessWidget {
  final MessageSticker sticker;
  const ItemContentSticker({Key? key, required this.sticker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String filePath =
        getIt<ITelegramService>().getLocalFile(sticker.sticker?.sticker?.id) ??
            '';

    String extension = p.extension(filePath);
    File file = File(filePath);
    bool fileExist = file.existsSync();
    Uint8List? tgsContent;
    if (fileExist) {
      if (extension == '.tgs') {
        tgsContent = TgsUtil.loadContent(file);
      }
    }

    double aspectRatio = sticker.sticker!.width! / sticker.sticker!.height!;

    Size size = ConstraintSize.size(
        aspectRatio: aspectRatio,
         context: context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: size.width, maxHeight: size.height),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: !fileExist
            ? Text(
                sticker.sticker?.emoji ?? '',
                style: TextStyle(fontSize: 30),
              )
            : AspectRatio(
                aspectRatio: aspectRatio,
                child: tgsContent != null
                    ? LottieBuilder.memory(tgsContent)
                    : Image.file(file),
              ),
      ),
    );
  }
}
