import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path/path.dart' as p;

String? checkGifExists(String animationPath) {
  File animationFile = File(animationPath);
  if (!animationFile.existsSync() || animationFile.lengthSync() == 0) {
    return null;
  }

  Directory directory = animationFile.parent;
  String fileName = p.basenameWithoutExtension(animationPath);

  File gifFile = File('${directory.path}/$fileName.gif');
  if (gifFile.existsSync() && gifFile.lengthSync() != 0) {
    return gifFile.path;
  }
  return null;
}

Future<String?> generateGif(String animationPath) async {
  File animationFile = File(animationPath);
  if (!animationFile.existsSync() || animationFile.lengthSync() == 0) {
    return null;
  }

  Directory directory = animationFile.parent;
  String fileName = p.basenameWithoutExtension(animationPath);

  File gifFile = File('${directory.path}/$fileName.gif');
  if (gifFile.existsSync() && gifFile.lengthSync() != 0) {
    return gifFile.path;
  }
  File paletteFile = File('${directory.path}/$fileName-palette.png');

  try {
    gifFile._delete();

    /// get width * height * fps
    int result = await FlutterFFprobe().execute(
        '-v error -select_streams v -show_entries stream=width,height,r_frame_rate -of json $animationPath');

    print('获取宽高结果: $result');
    if (result != 0) return null;

    String commandOutput = await FlutterFFmpegConfig().getLastCommandOutput();
    Map<String, dynamic> stream = jsonDecode(commandOutput)['streams'][0];
    int width = stream['width'];
    int height = stream['height'];
    int maxDimension = max(width, height);
    String fpsStr = stream['r_frame_rate'];
    List<String> frameRates = fpsStr.split('/');
    int fps = (int.tryParse(frameRates[0]) ?? 30) ~/
        (int.tryParse(frameRates[1]) ?? 1);

    print('whfps: width: $width, height: $height fps: $fps');

    paletteFile._delete();

    /// generate palette
    result = await FlutterFFmpeg().execute(
        '-i $animationPath -vf fps=$fps,scale=$maxDimension:-1:flags=lanczos,palettegen ${paletteFile.path}');

    print('生成调色盘结果: $result');
    if (result != 0) return null;

    /// generate gif image
    result = await FlutterFFmpeg().execute(
        '-i $animationPath -i ${paletteFile.path} -filter_complex "fps=$fps,scale=$maxDimension:-1:flags=lanczos[x];[x][1:v]paletteuse" ${gifFile.path}');

    print('生成gif结果: $result');
    if (result != 0) return null;

    return gifFile.path;
  } catch (e) {
    print("crap: $e");
    return null;
  } finally {
    paletteFile._delete();
  }
}

extension FileX on File {
  void _delete() {
    if (this.existsSync()) this.deleteSync();
  }
}
