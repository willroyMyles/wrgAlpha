import 'dart:async';

import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/userinfo.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/frontend/pages/offers/state.offers.dart';

class ProfileState extends GetxController {
  Rx<UserInfoModel>? userModel;
  RxBool isSignedIn = false.obs;

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

  remove() async {
    userModel = null;
    isSignedIn.value = false;
    refresh();
  }
}
