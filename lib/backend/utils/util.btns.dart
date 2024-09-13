import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

WidgetStatePropertyAll<T> wst<T>(T value) {
  return WidgetStatePropertyAll<T>(value);
}

class BS {
  static ButtonStyle get defaultBtnStyle => ButtonStyle(
      minimumSize: wst(Size(Get.width * .4, 40)),
      maximumSize: wst(Size(Get.width * .5, 40)),
      backgroundColor:
          WidgetStateProperty.all(toc.primaryColor.withOpacity(.9)),
      foregroundColor: WidgetStateProperty.all(toc.cardColor),
      textStyle: mst(const TextStyle(fontWeight: FontWeight.w600)),
      elevation: mst(0),
      shadowColor: mst(toc.scaffoldBackgroundColor),
      // animationDuration: Constants.fastAnimationSpeed,
      padding: mst(const EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
      shape: mst(RoundedRectangleBorder(borderRadius: Constants.br)));
}
