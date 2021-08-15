export 'package:model_tdapi/model_tdapi.dart';
import 'package:model_tdapi/model_tdapi.dart';
import 'package:collection/collection.dart';

Comparator<Chat> chatComparator = (Chat a, Chat b) {
  int positionA = a.positions?.firstOrNull?.order ?? 0;
  int positionB = b.positions?.firstOrNull?.order ?? 0;
  return positionB.compareTo(positionA);
};
