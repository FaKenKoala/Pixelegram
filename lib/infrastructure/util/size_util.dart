import 'dart:math';

String formatBytes({int bytes = 0, int decimals = 1, String splitter = ' '}) {
  if (bytes <= 0) return "0${splitter}B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
      splitter +
      suffixes[i];
}
