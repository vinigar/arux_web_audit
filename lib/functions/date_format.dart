import 'package:intl/intl.dart';

String dateFormat(DateTime? x) {
  if (x == null) return '-';
  String formattedDate = DateFormat('dd-MM-yyyy').format(x);
  return formattedDate;
}
