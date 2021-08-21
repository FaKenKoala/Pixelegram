import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pixelegram/domain/model/tdapi.dart' as td;
import 'package:pixelegram/domain/service/i_telegram_service.dart';
import 'package:pixelegram/infrastructure/get_it/main.dart';
import 'package:pixelegram/infrastructure/util/util.dart';
import 'package:pixelegram/presentation/custom_widget/custom_widget.dart';

class ItemContentAnimation extends StatefulWidget {
  final td.MessageAnimation animation;

  const ItemContentAnimation({Key? key, required this.animation})
      : super(key: key);

  @override
  _ItemContentAnimationState createState() => _ItemContentAnimationState();
}

class _ItemContentAnimationState extends State<ItemContentAnimation> {
  late double aspectRatio;
  String? gifPath;
  @override
  void initState() {
    super.initState();
    aspectRatio = widget.animation.animation!.width! /
        widget.animation.animation!.height!;
  }

  getGifPath() async {
    if (gifPath != null) return;
    gifPath = getIt<ITelegramService>()
        .getAnimationGif(widget.animation.animation?.animation?.id);
  }

  @override
  Widget build(BuildContext context) {
    getGifPath();
    Size size = ConstraintSize.size(aspectRatio: aspectRatio, context: context);
    String? minithumbData = widget.animation.animation!.minithumbnail!.data;
    File file = File(gifPath ?? '');
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: size.width, maxHeight: size.height),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: file.existsSync()
              ? Image.file(
                  file,
                  gaplessPlayback: true,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                )
              : minithumbData != null
                  ? Base64Image(base64Str: minithumbData)
                  : Container(),
        ),
      ),
    );
  }
}
