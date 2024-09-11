import 'package:intl/intl.dart';

String dateFormatted(DateTime datetime) {
  return DateFormat('d.MM.yyyy').format(datetime);
}
