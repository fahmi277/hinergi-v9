import 'package:intl/intl.dart';

class DateTimeClass {
  Map getTimeNow() {
    DateTime time = new DateTime.now();

    Map timeData = {
      "tanggal": new DateFormat("dd.MM.yyyy").format(time),
      "waktu": new DateFormat("hh:mm:ss").format(time)
    };

    return timeData;
  }
}
