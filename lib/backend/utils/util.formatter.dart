import 'package:intl/intl.dart';

extension DteTimeFormat on DateTime {
  String formatDateForPost() {
    var format = DateFormat('yyyy-MM-dd hh:mm:ss a');
    return format.format(this);
  }
}

extension EmailParse on String {
  String get parseEmail => split('@')[0];
}
