import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.btns.dart';
import 'package:wrg2/backend/utils/util.snackbars.dart';
import 'package:wrg2/backend/utils/util.widget.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

Future<bool> showBinaryPrompt(String question,
    {String? title, String? confirm, String? cancel}) async {
  bool? ans = false;
  ans = await Get.dialog(
      AlertDialog(
        elevation: 10,
        backgroundColor: toc.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: Constants.br,
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    title != null
                        ? Text(
                            title,
                            style: TS.h2,
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    GestureDetector(
                        onTap: () {
                          Get.back(result: false);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(left: 5),
                          child: Icon(
                            CupertinoIcons.xmark_circle,
                            size: 30,
                            color: toc.primaryColor,
                          ),
                        ))
                  ],
                ),
              ),
              wrgDivider(),
              Padding(
                padding: EdgeInsets.all(Constants.cardpadding),
                child: Text(
                  question,
                  style: TS.h3,
                ),
              ),
              // wrgDivider(),
              Constants.verticalSpace,
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  style: BS.defaultBtnStyle,
                  onPressed: () {
                    Get.back(result: true);
                  },
                  child: Text(confirm ?? "yes".capitalize!,
                      style: const TextStyle(fontWeight: FontWeight.w600))),
              const SizedBox(width: 20),
              TextButton(
                  style: BS.defaultEmpty,
                  onPressed: () {
                    Get.back(result: false);
                  },
                  child: Text(cancel ?? "no".capitalize!,
                      style: const TextStyle(fontWeight: FontWeight.w600))),
            ],
          ),
        ],
      ),
      useSafeArea: false);
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
      var res = await Get.find<GE>().signInWithGoogle();
      if (!res) {
        SBUtil.showErrorSnackBar(
            "Unable to sign in with google. Please try again later");
      }
      return false;
    } else {
      SBUtil.showInfoSnackBar("You need to be logged in to continue");
      return false;
    }
  }
  return true;
}
