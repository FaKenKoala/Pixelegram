import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pixelegram/infrastructure/util/util.dart';

class CircleImage extends StatelessWidget {
  final ImageProvider image;
  final String? text;

  const CircleImage({Key? key, required this.image, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: colorFromText(text),
        shape: BoxShape.circle,
        image: text == null
            ? DecorationImage(image: image, fit: BoxFit.contain)
            : null,
      ),
      child: text != null
          ? Center(
              child: Text(
                text?.toUpperCase() ?? '',
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
            )
          : null,
    );
  }
}

class CircleFileImage extends StatelessWidget {
  final String? filePath;
  final String? text;
  final double width, height;
  final double fontSize;

  const CircleFileImage({
    Key? key,
    required this.filePath,
    this.text,
    this.width = 60,
    this.height = 60,
    this.fontSize = 28,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool fileExists = filePath != null && File(filePath!).existsSync();

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colorFromText(text),
        shape: BoxShape.circle,
        image: fileExists
            ? DecorationImage(
                image: FileImage(File(filePath!)), fit: BoxFit.contain)
            : null,
      ),
      child: text != null
          ? Center(
              child: Text(
                text?.toUpperCase().substring(0, 1) ?? '',
                style: TextStyle(color: Colors.white, fontSize: fontSize),
              ),
            )
          : null,
    );
  }
}
