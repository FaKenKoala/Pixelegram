import 'dart:io';

import 'dart:typed_data';

class TgsUtil {
  static Uint8List? loadContent(File file) {
    if (!file.existsSync()) {
      return null;
    }
    return Uint8List.fromList(gzip.decode(file.readAsBytesSync()));
  }
}
