import 'package:get/get.dart';
import 'package:wrg2/backend/models/userinfo.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';

class ProfileState extends GetxController {
  Rx<UserInfoModel>? userModel;

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
    }

    refresh();
  }
}
