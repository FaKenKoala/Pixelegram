import 'package:dart_date/dart_date.dart';
import 'package:intl/intl.dart';
extension DateTimeX on DateTime{
  String format(){
    DateTime now = DateTime.now();
    if(this.isSameDay(now)){
      // show time
      return DateFormat('HH:mm').format(this);
    }

    if(this.isSameOrAfter(now.startOfWeek)) {
      // show week name
      return DateFormat.E().format(this);
    }

    if(this.isSameYear(now)){
      return DateFormat.MMMd().format(this);
    }

    return DateFormat.y().format(this);

  }
}