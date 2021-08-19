import 'dart:ui';
import 'dart:math';

class ConstraintSize {
  static Size size(
      {required double aspectRatio,
      double maxHeight = 300,
      required double screenWidth,
      double widthPadding = (10 + 40 + 8) * 2}) {
    double maxHeight = 300;
    double maxWidth =
        min(maxHeight * aspectRatio, screenWidth - (10 + 40 + 8) * 2);

    return Size(maxWidth, maxHeight);
  }
}
