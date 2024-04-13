import 'dart:math';

import 'package:flutter/material.dart';

MaterialColor generateMaterialColor({required Color color}) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.95),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);

Color hexToColor(String? code) {
  if (code == null) return Colors.amber;
  var col = Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  return col;
}

Color getRandomColor(double? seed) {
  int amount = ((seed! * 140) % 9).toInt();
  return Colors
      .primaries[Random(amount - 1).nextInt(Colors.primaries.length)].shade400
      .withOpacity(1);
}
