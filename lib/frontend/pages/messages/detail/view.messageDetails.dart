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
        bottomSheet: BottomSheet(
          onClosing: () {},
          builder: (context) => Container(
            color: toc.scaffoldBackgroundColor,
            child: SafeArea(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: Constants.cardpadding),
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
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              WRGAppBar(
                " ${initialOffer?.senderId ?? controller.conversation?.getOthersName() ?? ""}",
                additional: const Text(
                  "You're messages with",
                  textScaler: TextScaler.linear(.5),
                ),
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
              return StreamBuilder<Object>(
                  stream: controller.usersStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }

                    return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 150),
                        controller: controller.scroll,
                        physics: const ClampingScrollPhysics(),
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: controller.messages.isEmpty
                            ? 1
                            : controller.messages.length,
                        itemBuilder: (context, index) {
                          if (index - skipCount <= 0) {
                            return Container();
                          }
                          if (controller.messages.isEmpty || index == 0) {
                            var m = MessagesModel(
                                sender: initialOffer?.senderId ?? "",
                                content: initialOffer?.message ?? "",
                                id: "initial");

                            return Column(
                              children: [
                                if (initialOffer != null)
                                  Container(
                                    margin: Constants.ePadding,
                                    padding: Constants.ePadding,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: toc.cardColor,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const Text("initial Offer"),
                                        Text(
                                          "Sender: ${initialOffer?.senderId ?? ""}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Message: ${initialOffer?.message ?? ""}",
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                        Text(
                                          "Offer Price: ${initialOffer?.offerPrice ?? ""}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              _buildChip(
                                                  "has part",
                                                  initialOffer?.hasPart
                                                          ?.toString() ??
                                                      ""),
                                              _buildChip(
                                                  "Logistics",
                                                  initialOffer?.logistics ??
                                                      ""),
                                              _buildChip(
                                                  "Condition",
                                                  initialOffer?.condition ??
                                                      ""),
                                              _buildChip(
                                                  "Price",
                                                  initialOffer?.offerPrice ??
                                                      ""),
                                              _buildChip(
                                                  "Payment Method",
                                                  initialOffer?.paymentMethod ??
                                                      ""),
                                              _buildChip("Refund Policy",
                                                  initialOffer?.policy ?? ""),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                if (initialOffer == null) m.tile(),
                              ],
                            );
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

                          // if (index == 0) {
                          //   return Column(
                          //     children: [
                          //       const Text("first message"),
                          //       item.tile(),
                          //     ],
                          //   );
                          // }

                          return item.tile();
                        });
                  });
            },
            onEmpty: Constants.empty,
            onLoading: Constants.loading,
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String s, String t) {
    return Container(
      padding: Constants.ePadding,
      margin: Constants.ePadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: toc.scaffoldBackgroundColor,
      ),
      child: Column(
        children: [
          Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(s),
        ],
      ),
    );
  }
}
