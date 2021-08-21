import 'package:flutter/material.dart';
import 'package:pixelegram/application/router/router.dart';
import 'package:pixelegram/domain/model/tdapi.dart' as td;
import 'package:pixelegram/domain/service/i_telegram_service.dart';
import 'package:pixelegram/infrastructure/get_it/main.dart';
import 'package:pixelegram/presentation/custom_widget/custom_widget.dart';
import 'package:pixelegram/infrastructure/util/util.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ItemContentVideo extends StatefulWidget {
  final td.MessageVideo video;

  const ItemContentVideo({Key? key, required this.video}) : super(key: key);

  @override
  _ItemContentVideoState createState() => _ItemContentVideoState();
}

class _ItemContentVideoState extends State<ItemContentVideo> {
  late double aspectRatio;
  String? path;
  String? thumbnailPath;

  @override
  void initState() {
    super.initState();
    aspectRatio = widget.video.video!.width! / widget.video.video!.height!;
  }

  void _initPath() async {
    if (path != null) return;
    path =
        getIt<ITelegramService>().getLocalFile(widget.video.video?.video?.id);

    thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: path!,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      quality: 100,
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    _initPath();

    Size size = ConstraintSize.size(aspectRatio: aspectRatio, context: context);
    return GestureDetector(
      onTap: () {
        if (thumbnailPath != null) {
          getIt<AppRouter>().push(VideoPlayPageRoute(videoFile: path!, aspectRatio: aspectRatio));
        }
      },
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: size.width, maxHeight: size.height),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: Stack(
              children: [
                Positioned.fill(
                    child: thumbnailPath != null
                        ? Image.file(File(thumbnailPath!))
                        : Base64Image(
                            base64Str:
                                widget.video.video!.minithumbnail!.data!)),
                Center(
                  child: thumbnailPath != null
                      ? DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.play_arrow),
                          ))
                      : CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
