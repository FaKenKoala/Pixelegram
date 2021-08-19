import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pixelegram/domain/model/tdapi.dart' as td;
import 'package:pixelegram/domain/service/i_telegram_service.dart';
import 'package:pixelegram/infrastructure/get_it/main.dart';
import 'package:collection/collection.dart';
import 'package:pixelegram/infrastructure/util/util.dart';
import 'dart:math';

import 'package:pixelegram/presentation/custom_widget/custom_widget.dart';

class ItemContentPhoto extends StatelessWidget {
  final td.MessagePhoto photo;

  const ItemContentPhoto({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<td.PhotoSize> sizes = photo.photo!.sizes!..sort(td.sizeComparator);
    td.PhotoSize size = sizes.first;
    String path = getIt<ITelegramService>().getLocalFile(size.photo?.id) ?? '';
    File file = File(path);
    double aspectRatio = size.width! / size.height!;
    Size constraintSize = ConstraintSize.size(
      minWidth: 70,
        aspectRatio: aspectRatio,
        screenWidth: MediaQuery.of(context).size.width);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        constraints: BoxConstraints(
            minWidth: 70, maxWidth: constraintSize.width, maxHeight: constraintSize.height),
        color: Colors.grey.withAlpha(128),
        child: AspectRatio(
            aspectRatio: size.width! / size.height!,
            child: file.existsSync()
                ? Image.file(
                    File(path),
                    fit: BoxFit.contain,
                  )
                : Base64Image(base64Str: photo.photo!.minithumbnail!.data!)),
      ),
    );
  }
}
