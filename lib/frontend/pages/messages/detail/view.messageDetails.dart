import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/models/messages.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/messages/detail/state.messageDetails.dart';
import 'package:wrg2/frontend/pages/messages/detail/view.messageItem.dart';

class MessageDetailView extends StatelessWidget {
  final OfferModel? initialOffer;
  MessageDetailView({super.key, this.initialOffer});
  final controller = Get.put(MessageDetailsState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: false,
      // appBar: WRGAppBar("hello world"),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Constants.cardpadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: buildInput("message", (val) {},
                      showHelper: false,
                      height: 50,
                      tec: controller.controller)),
              TextButton(
                  onPressed: () {
                    controller.onSend();
                  },
                  child: const Text("send"))
            ],
          ),
        ),
      ),

      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            CupertinoSliverNavigationBar(
              largeTitle:
                  Text("Your Message with ${initialOffer?.senderId ?? ''}"),
              stretch: true,
              transitionBetweenRoutes: true,
              alwaysShowMiddle: false,
              border: const Border(),
            ),
            SliverAppBar(
                toolbarHeight: 50,
                expandedHeight: 50,
                floating: false,
                pinned: true,
                snap: false,
                automaticallyImplyLeading: false,
                backgroundColor: toc.scaffoldBackgroundColor.darkerF(10),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(onPressed: () {}, child: const Text("Decline")),
                    SizedBox(width: Constants.cardMargin),
                    TextButton(onPressed: () {}, child: const Text("Accept")),
                  ],
                )),
          ];
        },
        body: controller.obx(
          (state) => Container(
              child: ListView.builder(
                  itemCount: controller.messages.isEmpty
                      ? 1
                      : controller.messages.length,
                  itemBuilder: (context, index) {
                    if (controller.messages.isEmpty) {
                      var m = MessagesModel(
                          sender: initialOffer?.senderId ?? "",
                          content: initialOffer?.message ?? "",
                          id: "initial");
                      return MessageItem(item: m);
                    }
                    var item = controller.messages[index];
                    return MessageItem(item: item);
                  })),
          onEmpty: Constants.empty,
          onLoading: Constants.loading,
        ),
      ),
    );
  }
}
