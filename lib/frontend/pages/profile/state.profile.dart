import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/userinfo.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/utils/util.snackbars.dart';
import 'package:wrg2/frontend/pages/offers/state.offers.dart';

class ProfileState extends GetxController {
  Rx<UserInfoModel>? userModel;
  RxBool isSignedIn = false.obs;
  String feedback = "";

  setup() async {
    var res = await Get.find<GE>().user_getUser();
    if (res != null) {
      userModel = res.obs;
      userModel!.refresh();
      isSignedIn.value = true;
    }

    Future.delayed(const Duration(seconds: 1), () {
      GFI<OfferState>()?.setup();
    });

    refresh();
  }

  Future<bool> onSendFeedback() async {
    if (feedback.isEmpty) {
      SBUtil.showErrorSnackBar("Please enter message");
      return false;
    }
    var endpoint =
        "https://hooks.slack.com/services/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";
    var data = {
      "text":
          "Feedback from email :${userModel?.value.email} \n name : ${userModel?.value.username} \n alias : ${userModel?.value.alias}\nfeedback: $feedback"
    };
    var res =
        await http.post(Uri.parse(endpoint), body: jsonEncode(data), headers: {
      "Content-Type": "application/json",
    });

    if (res.statusCode == 200) {
      SBUtil.showSuccessSnackBar("Feedback sent");
      feedback = "";
      return true;
    } else {
      SBUtil.showErrorSnackBar("Failed to send feedback");
      return false;
    }

    return false;
  }

  remove() async {
    userModel = null;
    isSignedIn.value = false;
    refresh();
  }

  onRefresh() {
    userModel!.refresh();
    refresh();
  }
}
