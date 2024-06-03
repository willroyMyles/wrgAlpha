import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

extension CD on Color {
  Color get darker => Color.fromRGBO((red - 40).clamp(0, 255),
      (green - 40).clamp(0, 255), (blue - 40).clamp(0, 255), opacity);
  Color darkerF(int amt) => Color.fromRGBO((red - amt).clamp(0, 255),
      (green - amt).clamp(0, 255), (blue - amt).clamp(0, 255), opacity);

  Color get lighter => Color.fromRGBO((red + 40).clamp(0, 255),
      (green + 40).clamp(0, 255), (blue + 40).clamp(0, 255), opacity);

  Color lighterF(int amt) => Color.fromRGBO((red + amt).clamp(0, 255),
      (green + amt).clamp(0, 255), (blue + amt).clamp(0, 255), opacity);

  Color get more => Get.isDarkMode ? lighter : darker;
  Color get less => Get.isDarkMode ? darker : lighter;
}
