import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

extension DteTimeFormat on DateTime {
  String formatDateForPost() {
    var format = DateFormat('yyyy-MM-dd hh:mm:ss a');
    return format.format(this);
  }
}

extension EmailParse on String {
  String get parseEmail => split('@')[0];
}

var mobileFormatter = MaskTextInputFormatter(
    mask: '+# (###) ###-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);
