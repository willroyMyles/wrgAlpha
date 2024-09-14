import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

WidgetStatePropertyAll<T> wst<T>(T value) {
  return WidgetStatePropertyAll<T>(value);
}

class BS {
  static ButtonStyle get defaultBtnStyle => ButtonStyle(
      minimumSize: wst(Size(Get.width * .4, 50)),
      maximumSize: wst(Size(Get.width * .5, 50)),
      backgroundColor:
          WidgetStateProperty.all(toc.primaryColor.withOpacity(.9)),
      foregroundColor: WidgetStateProperty.all(toc.cardColor),
      textStyle:
          mst(const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      elevation: mst(0),
      shadowColor: mst(toc.scaffoldBackgroundColor),
      // animationDuration: Constants.fastAnimationSpeed,
      padding: mst(const EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
      shape:
          mst(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));

  static ButtonStyle get secondaryBtnStyle => ButtonStyle(
      minimumSize: wst(Size(Get.width * .4, 50)),
      maximumSize: wst(Size(Get.width * .5, 50)),
      backgroundColor:
          WidgetStateProperty.all(toc.scaffoldBackgroundColor.darker),
      foregroundColor: WidgetStateProperty.all(toc.textColor),
      textStyle:
          mst(const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      elevation: mst(0),
      shadowColor: mst(toc.scaffoldBackgroundColor),
      // animationDuration: Constants.fastAnimationSpeed,
      padding: mst(const EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
      shape:
          mst(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));

  static ButtonStyle get plainBtnStyle => ButtonStyle(
      minimumSize: wst(Size(Get.width * .4, 50)),
      maximumSize: wst(Size(Get.width * .5, 50)),
      backgroundColor:
          WidgetStateProperty.all(toc.scaffoldBackgroundColor.withOpacity(0)),
      foregroundColor: WidgetStateProperty.all(toc.primaryColor),
      textStyle:
          mst(const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      elevation: mst(0),
      shadowColor: mst(toc.scaffoldBackgroundColor),
      // animationDuration: Constants.fastAnimationSpeed,
      padding: mst(const EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
      shape:
          mst(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
}
