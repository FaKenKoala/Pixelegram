import 'dart:math';

import 'package:flutter/material.dart';

const BackgroundColorList = [
  const Color(0xFFEF5350),
  const Color(0xFFEC407A),
  const Color(0xFFAB47BC),
  const Color(0xFF7E57C2),
  const Color(0xFF5C6BC0),
  const Color(0xFF42A5F5),
  const Color(0xFF29B6F6),
  const Color(0xFF26C6DA),
  const Color(0xFF26A69A),
  const Color(0xFF66BB6A),
  const Color(0xFF9CCC65),
  const Color(0xFFD4E157),
  const Color(0xFFFFEE58),
  const Color(0xFFFFCA2),
  const Color(0xFFFFA726),
  const Color(0xFFFF7043),
];

const ColorsWhite90 = const Color(0xF0FFFFFF);
const ColorsWhite80 = const Color(0xC4FFFFFF);

Color randomColor([int? index]) {
  int pos = index ?? Random().nextInt(BackgroundColorList.length);
  return BackgroundColorList[pos %= BackgroundColorList.length];
}

Color colorFromText([String? text]) {
  int index =
      ((text?.isNotEmpty ?? false) ? text!.toUpperCase() : 'A').codeUnits.first;
  return randomColor(index);
}
