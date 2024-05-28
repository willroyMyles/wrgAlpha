import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/userinfo.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/frontend/pages/offers/state.offers.dart';

class ProfileState extends GetxController {
  Rx<UserInfoModel>? userModel;
  RxBool isSignedIn = false.obs;
  String feedback = "";

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

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

  onSendFeedback() async {
    var endpoint =
        "https://hooks.slack.com/services/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";
    var data = {
      "text":
          "Feedback from ${userModel?.value.email} \n ${userModel?.value.userId} \n ${userModel?.value.alias}\nfeedback: $feedback"
    };
    var res =
        await http.post(Uri.parse(endpoint), body: jsonEncode(data), headers: {
      "Content-Type": "application/json",
    });
    print(res.statusCode);
  }

  remove() async {
    userModel = null;
    isSignedIn.value = false;
    refresh();
  }
}
