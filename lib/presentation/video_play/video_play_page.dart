import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';
import 'package:pixelegram/application/router/router.dart';
import 'package:pixelegram/infrastructure/get_it/main.dart';

class VideoPlayPage extends StatefulWidget {
  final String videoFile;
  final double? aspectRatio;

  const VideoPlayPage({Key? key, required this.videoFile, this.aspectRatio})
      : super(key: key);

  @override
  _VideoPlayPageState createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  late BetterPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BetterPlayerController(
        BetterPlayerConfiguration(
            autoPlay: true,
            autoDispose: true,
            aspectRatio: widget.aspectRatio,
            fullScreenAspectRatio: widget.aspectRatio,
            deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp]),
        betterPlayerDataSource: BetterPlayerDataSource.file(widget.videoFile));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            getIt<AppRouter>().pop();
          },
        ),
      ),
      body: Center(
        child: BetterPlayer(
          controller: _controller,
        ),
      ),
    );
  }
}
