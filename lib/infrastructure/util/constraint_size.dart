import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

class ConstraintSize {
  static Size size(
      {required double aspectRatio,
      double minWidth = 0,
      double maxHeight = 300,
      required BuildContext context,
      double widthPadding = (10 + 40 + 8) * 2}) {
    double maxHeight = 300;
    double maxWidth = max(minWidth,
        min(maxHeight * aspectRatio, MediaQuery.of(context).size.width - (10 + 40 + 8) * 2));

    return Size(maxWidth, maxHeight);
  }

  static double maxWidth(BuildContext context,
      {double widthPadding = (10 + 40 + 8) * 2}) {
    return MediaQuery.of(context).size.width - widthPadding;
  }
}
