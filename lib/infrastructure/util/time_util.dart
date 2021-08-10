class TimeUtil {
  /// mm:ss
  static String ms([int seconds = 0]) {
    int min = seconds ~/ 60;
    int sec = seconds % 60;

    String parsedTime = min.toString() + ":" + sec.toString().padLeft(2, '0');

    return parsedTime;
  }
}
