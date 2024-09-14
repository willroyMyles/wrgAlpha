import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.snackbars.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

Future<bool> showBinaryPrompt(String question, {String? title}) async {
  bool? ans = false;
  ans = await Get.dialog(AlertDialog(
    elevation: 10,
    backgroundColor: toc.cardColor,
    shape: RoundedRectangleBorder(
      borderRadius: Constants.br,
    ),
    title: title != null ? Text(title) : null,
    content: Container(
      child: Text(
        question,
        style: TextStyle(fontWeight: FontWeight.w600, color: toc.textColor),
      ),
    ),
    actions: [
      TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: Text("no".capitalize!,
              style: const TextStyle(fontWeight: FontWeight.w600))),
      TextButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: Text("yes".capitalize!,
              style: const TextStyle(fontWeight: FontWeight.w600))),
    ],
  ));
  ans ??= false;
  return ans;
}

Future<bool> showBinaryPromptWidget(Widget question, {String? title}) async {
  bool? ans = false;
  ans = await Get.dialog(AlertDialog(
    elevation: 10,
    backgroundColor: toc.cardColor,
    shape: RoundedRectangleBorder(
      borderRadius: Constants.br,
    ),
    title: title != null ? Text(title) : null,
    content: Container(
      child: question,
    ),
    actions: [
      TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: Text("no".capitalize!,
              style: const TextStyle(fontWeight: FontWeight.w600))),
      TextButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: Text("yes".capitalize!,
              style: const TextStyle(fontWeight: FontWeight.w600))),
    ],
  ));
  ans ??= false;
  return ans;
}

Future<bool> guardPrompt() async {
  var isLoggedIn = GF<ProfileState>().isSignedIn.value;
  if (!isLoggedIn) {
    bool? result = await showBinaryPrompt(
        'You are not logged in. Do you want to log in?',
        title: 'Login Required');
    if (result) {
      // navigate to login page or perform login logic
      return false;
    } else {
      SBUtil.showInfoSnackBar("You need to be logged in to continue");
      return false;
    }
  }
  return true;
}
