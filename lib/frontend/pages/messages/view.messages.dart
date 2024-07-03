import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';
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
          return [const WRGAppBar("Your Messages")];
        },
        body: controller.obx(
          (state) => ListView.builder(
            itemCount: controller.conversations.length,
            itemBuilder: (context, index) {
              var item = controller.conversations[index];
              return item.tile();
            },
          ),
          onEmpty: Constants.emptyWidget("No Messages"),
          onLoading: Constants.loading,
        ),
      ),
    );
  }
}
