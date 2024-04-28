import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/pages/messages/state.messages.dart';

class MessagesView extends StatelessWidget {
  MessagesView({super.key});
  final controller = Get.put(MessagesState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: WRGAppBar("hello world"),

      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const CupertinoSliverNavigationBar(
              largeTitle: Text("Your Messages"),
              stretch: true,
              transitionBetweenRoutes: true,
              alwaysShowMiddle: false,
              border: Border(),
            ),
          ];
        },
        body: controller.obx(
          (state) => Container(
            child: ListView.builder(
              itemCount: 0,
              itemBuilder: (context, index) {
                return null;
              },
            ),
          ),
          onEmpty: Constants.empty,
          onLoading: Constants.loading,
        ),
      ),
    );
  }
}
