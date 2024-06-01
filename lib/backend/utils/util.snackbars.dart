import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

class SBUtil {
  static Future showErrorSnackBar(String message) async {
    // Show snackbar
    var icon = const Icon(
      Icons.dangerous,
      color: Colors.red,
      size: 30,
    );
    await _showSnackBar("Error", message, icon);
  }

  static Future showSuccessSnackBar(String message) async {
    // Show snackbar
    var icon = const Icon(
      Icons.check,
      color: Colors.green,
      size: 30,
    );
    await _showSnackBar("Success", message, icon);
  }

  static _showSnackBar(String title, String msg, Widget icon) async {
    // Show snackbar
    try {
      Get.showSnackbar(GetSnackBar(
        // title: "",
        titleText: Txt(title).h2,

        message: msg,
        // margin: EdgeInsets.symmetric(horizontal: 5),
        borderRadius: Constants.lightOpacity,
        icon: icon,
        duration: Constants.longAnimationSpeed,
        snackStyle: SnackStyle.GROUNDED,
        barBlur: 5,
        messageText: Txt(
          msg,
        ).h3,
        showProgressIndicator: true,

        backgroundColor: toc.cardColor.withOpacity(.4),
      ));
    } catch (e) {}
  }
}
