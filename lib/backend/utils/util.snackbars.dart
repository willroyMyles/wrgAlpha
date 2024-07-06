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

  static Future showInfoSnackBar(String message) async {
    // Show snackbar
    var icon = const Icon(
      Icons.info_outline,
      color: Colors.blue,
      size: 30,
    );
    await _showSnackBar("Info", message, icon);
  }

  static _showSnackBar(String title, String msg, Widget icon) async {
    // Show snackbar
    try {
      Get.showSnackbar(GetSnackBar(
        // title: "",
        titleText: Text(
          title,
          style: TS.h3,
        ),

        message: msg,
        borderRadius: Constants.lightOpacity,
        icon: icon,
        duration: Constants.longAnimationSpeed,
        snackStyle: SnackStyle.GROUNDED,
        barBlur: 5,
        messageText: Text(
          msg,
          style: TS.h4,
        ),
        showProgressIndicator: true,
        backgroundColor: toc.cardColor.withOpacity(1),
      ));
    } catch (e) {}
  }
}
