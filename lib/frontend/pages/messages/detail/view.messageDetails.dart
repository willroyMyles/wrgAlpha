import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/models/messages.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';
import 'package:wrg2/frontend/pages/messages/detail/state.messageDetails.dart';

class MessageDetailView extends StatelessWidget {
  final OfferModel? initialOffer;
  MessageDetailView({super.key, this.initialOffer});
  final controller = Get.put(MessageDetailsState());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: toc.scaffoldBackgroundColor,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: false,

        bottomSheet: Container(
          color: toc.scaffoldBackgroundColor,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Constants.cardpadding),
              //remove marge on keyboard visibility
              margin: const EdgeInsets.only(bottom: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: buildInput("message", (val) {},
                          showHelper: false,
                          height: 45,
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
        ),
        // bottomNavigationBar: Container(
        //   padding: EdgeInsets.symmetric(horizontal: Constants.cardpadding),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Expanded(
        //           child: buildInput("message", (val) {},
        //               showHelper: false, height: 50, tec: controller.controller)),
        //       TextButton(
        //           onPressed: () {
        //             controller.onSend();
        //           },
        //           child: const Text("send"))
        //     ],
        //   ),
        // ),

        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              WRGAppBar(
                " ${initialOffer?.senderId ?? controller.conversation?.getOthersName() ?? ""}",
                additional: "You're messages with",
                bottom: PreferredSize(
                  preferredSize: Size(Get.width, 50),
                  child: Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {}, child: const Text("Decline")),
                          SizedBox(width: Constants.cardMargin),
                          TextButton(
                              onPressed: () {}, child: const Text("Accept")),
                        ],
                      )),
                ),
              )
            ];
          },
          body: controller.obx(
            (state) {
              var skipCount = -1;
              return Container(
                  child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: controller.messages.isEmpty
                            ? 1
                            : controller.messages.length,
                        itemBuilder: (context, index) {
                          if (index - skipCount <= 0) {
                            return Container();
                          }
                          if (controller.messages.isEmpty) {
                            var m = MessagesModel(
                                sender: initialOffer?.senderId ?? "",
                                content: initialOffer?.message ?? "",
                                id: "initial");

                            return m.tile();
                          }

                          var item = controller.messages[index];

                          var arr = [];
                          // check if the next message is from the same sender
                          var nextIndex = index + 1;
                          while (nextIndex < controller.messages.length) {
                            var next = controller.messages[nextIndex];
                            if (next.sender == item.sender) {
                              arr.add(next);
                              skipCount = index;
                              nextIndex++;
                            } else {
                              break;
                            }
                          }

                          if (arr.isNotEmpty) {
                            skipCount = index + arr.length;
                            return MessagesModel.multiTile([item, ...arr]);
                          }

                          return item.tile();
                        }),
                  ),
                ],
              ));
            },
            onEmpty: Constants.empty,
            onLoading: Constants.loading,
          ),
        ),
      ),
    );
  }
}
