import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.btns.dart';
import 'package:wrg2/backend/utils/util.formatter.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';
import 'package:wrg2/frontend/comps/comp.scaffold.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class EditProfile extends GetView<ProfileState> {
  EditProfile({super.key});

  Map<String, String> map = {};

  @override
  Widget build(BuildContext context) {
    return WRGScaffold(
      appbar: const WRGAppBar(
        "Edit Profile",
      ),
      child: Container(
        padding: EdgeInsets.all(Constants.cardpadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildInput("name", (v) {
                map['username'] = v;
              }, initialValue: controller.userModel!.value.username),
              Constants.verticalSpace,
              Constants.verticalSpace,
              buildInput("mobile Phone  +1 (876) 000-0000", (v) {
                map['mobile'] = v;
              },
                  initialValue: controller.userModel!.value.mobile,
                  formatter: mobileFormatter),
              Constants.verticalSpace,
              Constants.verticalSpace,
              TextButton(
                  style: BS.defaultBtnStyle,
                  onPressed: () async {
                    controller.updateProfile(map);
                  },
                  child: const Text("Sumbmt"))
            ],
          ),
        ),
      ),
    );
  }
}
