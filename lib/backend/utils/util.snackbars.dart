import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class SBUtil {
  static bool signInGuardPrmopt() {
    var user = Get.find<ProfileState>().userModel;
    if (user == null) {
      //throw error
      SBUtil.showErrorSnackBar("You need to be sign in to bookmark this post.");
      return false;
    }
    return true;
  }

  static Future showErrorSnackBar(String message) async {
    // Show snackbar
    var icon = const Icon(
      Icons.dangerous,
      // color: Colors.red,
      size: 30,
    );
    await _showSnackBar("Error", message, icon, color: Colors.red);
  }

  static Future showSuccessSnackBar(String message, {Widget? extra}) async {
    // Show snackbar
    var icon = const Icon(
      Icons.check,
      // color: Colors.green,
      size: 30,
    );
    await _showSnackBar("Success", message, icon,
        color: Colors.green, extra: extra);
  }

  static Future showInfoSnackBar(String message, {Widget? extra}) async {
    // Show snackbar
    var icon = const Icon(
      Icons.info_outline,
      // color: Colors.blue,
      size: 30,
    );
    await _showSnackBar("Info", message, icon,
        color: Colors.blue, extra: extra);
  }

  static _showSnackBar(String title, String msg, Widget icon,
      {Color? color, Widget? extra}) async {
    // Show snackbar
    try {
      Get.showSnackbar(GetSnackBar(
        // title: "",
        titleText: Text(
          "\n$title",
          style: TS.h3.bold,
        ),

        message: msg,
        borderRadius: Constants.lightOpacity,
        icon: icon,
        duration: const Duration(seconds: 3),
        snackStyle: SnackStyle.GROUNDED,
        barBlur: 5,
        shouldIconPulse: false,
        padding: const EdgeInsets.only(top: 5),
        margin: EdgeInsets.zero,
        messageText: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg,
              style: TS.h4.bold,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (extra != null) extra,
              ],
            )
          ],
        ),
        showProgressIndicator: false,
        borderWidth: 2,

        backgroundColor: (color ?? toc.cardColor).withOpacity(1),
      ));
    } catch (e) {}
  }
}
