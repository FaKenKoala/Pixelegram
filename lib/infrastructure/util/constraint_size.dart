import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

class ConstraintSize {
  static Size size(
      {required double aspectRatio,
      double minWidth = 0,
      double maxHeight = 300,
      required double screenWidth,
      double widthPadding = (10 + 40 + 8) * 2}) {
    double maxHeight = 300;
    double maxWidth = max(minWidth,
        min(maxHeight * aspectRatio, screenWidth - (10 + 40 + 8) * 2));

    return Size(maxWidth, maxHeight);
  }

  static double maxWidth(BuildContext context,
      {double widthPadding = (10 + 40 + 8) * 2}) {
    return MediaQuery.of(context).size.width - widthPadding;
  }
}
