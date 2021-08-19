import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pixelegram/domain/model/tdapi.dart' as td;
import 'package:pixelegram/domain/service/i_telegram_service.dart';
import 'package:pixelegram/infrastructure/get_it/main.dart';
import 'package:pixelegram/infrastructure/util/util.dart';
import 'package:pixelegram/presentation/custom_widget/custom_widget.dart';
import 'package:video_player/video_player.dart';
import 'dart:math';

class ItemContentAnimation extends StatefulWidget {
  final td.MessageAnimation animation;

  const ItemContentAnimation({Key? key, required this.animation})
      : super(key: key);

  @override
  _ItemContentAnimationState createState() => _ItemContentAnimationState();
}

class _ItemContentAnimationState extends State<ItemContentAnimation> {
  VideoPlayerController? _controller;
  late double aspectRatio;
  String? path;
  @override
  void initState() {
    super.initState();
    aspectRatio = widget.animation.animation!.width! /
        widget.animation.animation!.height!;
  }

  void _initController() {
    if (_controller != null) return;

    path = getIt<ITelegramService>()
        .getLocalFile(widget.animation.animation?.animation?.id);

    print('路径path: $path, _controller: $_controller');

    if (path != null && File(path!).existsSync()) {
      _controller = VideoPlayerController.file(File(path!))
        ..initialize().then((value) {
          setState(() {
            _controller!.play();
          });
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initController();

    Size size = ConstraintSize.size(
        aspectRatio: aspectRatio,
        screenWidth: MediaQuery.of(context).size.width);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: size.width, maxHeight: size.height),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: _controller != null && _controller!.value.isInitialized
              ? VideoPlayer(_controller!)
              : Base64Image(
                  base64Str: widget.animation.animation!.minithumbnail!.data!),
        ),
      ),
    );
  }
}
