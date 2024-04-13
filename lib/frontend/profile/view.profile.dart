import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/profile/state.profile.dart';

class ProfileView extends GetView<ProfileState> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: Constants.ePadding,
        child: GetBuilder<ProfileState>(
            init: controller,
            initState: (_) {},
            builder: (_) {
              return Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (controller.userModel != null)
                        Hero(
                          tag: "profile icon",
                          child: Container(
                              height: 55,
                              width: 55,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100)),
                              child: InkWell(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: CircleAvatar(
                                  radius: 35,
                                  child: Obx(() => Image.network(controller
                                      .userModel!.value.userImageUrl)),
                                ),
                              )),
                        ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (controller.userModel == null)
                            TextButton(
                                onPressed: () async {
                                  await Get.find<GE>().signInWithGoogle();
                                },
                                child: const Text("Log in")),
                          TextButton(
                              onPressed: () {}, child: const Text("Feedback")),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ]),
              );
            }),
      ),
    ));
  }
}
