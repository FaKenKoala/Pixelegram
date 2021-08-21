export 'package:model_tdapi/model_tdapi.dart';
import 'package:model_tdapi/model_tdapi.dart';
import 'package:collection/collection.dart';

Comparator<Chat> chatComparator = (Chat a, Chat b) {
  int positionA = a.positions?.firstOrNull?.order ?? 0;
  int positionB = b.positions?.firstOrNull?.order ?? 0;
  return positionB.compareTo(positionA);
};

Comparator<Message> messageComparator = (Message a, Message b) {
  return a.id!.compareTo(b.id!);
};

Comparator<PhotoSize> sizeComparator = (PhotoSize a, PhotoSize b) {
  bool widthLarger = a.width! >= a.height!;
  if (widthLarger) {
    return b.width!.compareTo(a.width!);
  }
  return b.height!.compareTo(a.height!);
};
