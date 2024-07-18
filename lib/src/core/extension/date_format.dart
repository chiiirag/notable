import 'package:intl/intl.dart';

extension DateTimeFormat on int {
  //Convert & format date
  String getFormattedDate() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(dateTime);
    return formattedDate;
  }
}
