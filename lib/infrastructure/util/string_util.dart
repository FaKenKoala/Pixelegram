import 'dart:convert';

extension StringX on String {
  String replaceNewLines([String replaceStr = ' ']) {
    return this.replaceAllMapped(RegExp(r'\n+'), (match) {
      return replaceStr;
    });
  }

  String jsonFormat(){
    return JsonEncoder.withIndent('  ').convert(jsonDecode(this));
  }
}
