import 'package:timeago/timeago.dart' as timeago;

extension TAGO on DateTime {
  String get ago => timeago.format(this);
}
