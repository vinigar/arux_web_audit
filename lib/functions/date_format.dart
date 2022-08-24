import 'package:intl/intl.dart';

String dateFormat(DateTime? x) {
  String formattedDate = DateFormat('dd-MM-yyyy').format(x!);
  return formattedDate;
}
