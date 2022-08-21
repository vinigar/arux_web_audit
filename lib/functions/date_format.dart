import 'package:intl/intl.dart';

String dateFormat(DateTime? x) {
  String formattedDate = DateFormat('yyyy-MM-dd').format(x!);
  return formattedDate;
}
