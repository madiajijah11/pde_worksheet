import 'package:intl/intl.dart';

String formatDateTime(String dateTime) {
  final parsedDateTime = DateTime.parse(dateTime);
  return DateFormat.yMMMMEEEEd().add_Hms().format(parsedDateTime);
}
