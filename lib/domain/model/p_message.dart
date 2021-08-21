import 'package:equatable/equatable.dart';
import 'package:pixelegram/domain/model/tdapi.dart';

class PMessage with EquatableMixin implements Comparable<PMessage> {
  final Message message;

  PMessage(this.message);
  @override
  List<Object?> get props => [message.id];

  @override
  int compareTo(PMessage other) => message.id!.compareTo(other.message.id!);
}
