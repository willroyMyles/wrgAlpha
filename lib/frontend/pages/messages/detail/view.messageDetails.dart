import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/conversation.dart';
import 'package:wrg2/backend/models/messages.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.btns.dart';
import 'package:wrg2/backend/utils/util.promptHelper.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/messages/detail/state.messageDetails.dart';
import 'package:wrg2/frontend/pages/messages/state.messages.dart';

class MessageDetailView extends StatelessWidget {
  OfferModel? initialOffer;
  MessageDetailView({super.key, this.initialOffer});
  final controller = Get.put(MessageDetailsState());

  @override
  Widget build(BuildContext context) {
    initialOffer ??= controller.initial;

    // return Container();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: false,
      // backgroundColor: Colors.black,
      bottomSheet: GetBuilder<MessageDetailsState>(
        init: controller,
        builder: (_) {
          initialOffer ??= controller.initial;

          // var convo = GFI<MessagesState>()
          //     ?.conversations
          //     .firstWhereOrNull((e) => e.id == controller.conversation?.id);

          // if ((initialOffer?.amISender ?? true) ||
          //     (convo != null && convo.messages.isNotEmpty)) {
          //   return BottomSheet(
          //     onClosing: () {},
          //     builder: (context) => Container(
          //       color: toc.scaffoldBackgroundColor,
          //       child: SafeArea(
          //         child: Container(
          //           padding:
          //               EdgeInsets.symmetric(horizontal: Constants.cardpadding),
          //           //remove marge on keyboard visibility
          //           margin: const EdgeInsets.only(bottom: 40),
          //           child: Row(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Expanded(
          //                   child: buildInput("message", (val) {},
          //                       showHelper: false,
          //                       height: 45,
          //                       tec: controller.controller)),
          //               TextButton(
          //                   onPressed: () {
          //                     controller.onSend();
          //                   },
          //                   child: const Text("send"))
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   );
          // }

          return Container(
            height: 0,
          );
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Opacity(
            opacity: .6,
            child: Text(
              "You're messages with",
              textScaler: TextScaler.linear(.8),
            ),
          ),
          GetBuilder<MessageDetailsState>(
            init: controller,
            initState: (_) {},
            builder: (_) {
              return Text(
                  "${(initialOffer?.amISender ?? false) ? initialOffer?.recieverId : initialOffer?.senderId}");
            },
          ),
        ]),
        bottom: !(initialOffer?.amISender ?? false)
            ? PreferredSize(
                preferredSize: Size(Get.width, 50),
                child: GetBuilder<MessageDetailsState>(
                  init: controller,
                  initState: (_) {},
                  builder: (_) {
                    if (initialOffer?.status == OfferStatus.Accepted ||
                        initialOffer?.status == OfferStatus.Declined) {
                      return Container(
                        color: initialOffer?.status?.color.withOpacity(.15),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "This offer was ${initialOffer!.status!.displayName.toLowerCase()}"
                              .capitalize!,
                          style: TS.h3.copyWith(
                              color: initialOffer?.status?.color.darker),
                        ),
                      );
                    }
                    if (_.status.isSuccess) {
                      return Container(
                          child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const VerticalDivider(),

                              TextButton(
                                  onPressed: () async {
                                    var res = await showBinaryPrompt(
                                        "By Declining this offer, you agree that this person will not undertake your request and futher conversations with this person will be suspended. Do you wish to continue?");

                                    if (res) {
                                      controller.onDecline();
                                    }
                                  },
                                  child: const Text("Decline")),
                              // SizedBox(width: Constants.cardMargin),
                              const VerticalDivider(),
                              TextButton(
                                  onPressed: () async {
                                    var res = await showBinaryPrompt(
                                        "By Accepting this offer, you agree that this person will be undertaking your request and all other offers will be disregarded. Do you wish to continue?");

                                    if (res) {
                                      controller.onAccept();
                                    }
                                  },
                                  child: const Text("Accept")),
                              const VerticalDivider(),
                            ],
                          ),
                        ],
                      ));
                    }

                    return Container();
                  },
                ),
              )
            : PreferredSize(
                preferredSize: const Size(0, 0), child: Container()),
      ),
      body: controller.obx(
        (state) {
          return StreamBuilder<List<ConversationModel>>(
              stream: GFI<MessagesState>()?.stream,
              builder: (context, snapshot) {
                ConversationModel? convo;

                if (snapshot.hasData) {
                  convo = GFI<MessagesState>()?.conversations.firstWhereOrNull(
                      (e) => e.id == controller.conversation?.id);
                  controller.ensureVisible();
                }

                return SingleChildScrollView(
                  controller: controller.scroll,
                  // physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: Constants.cardMargin),
                      _buildInitial(),
                      if (!(initialOffer?.amISender ?? false)) _buildEmpty(),
                      // _buildSender(),
                      // if (controller.conversation == null) _buildEmpty(),
                      // Builder(builder: (context) {
                      //   if (convo != null) {
                      //     return Container(
                      //       child: Column(
                      //           children: convo.messages.map((e) {
                      //         return e.tile(e == convo!.messages.last
                      //             ? controller.last
                      //             : null);
                      //       }).toList()),
                      //     );
                      //   }

                      //   return Container(
                      //     child: const Text("No conversation"),
                      //   );
                      // }),
                      const SizedBox(height: 20),
                      if (!(initialOffer?.amISender ?? false))
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (initialOffer?.mobile?.isNotEmpty ?? false)
                              TextButton(
                                style: BS.defaultBtnStyle,
                                onPressed: () {},
                                child: const Text("Whatsapp"),
                              ),
                            TextButton(
                              style: BS.defaultBtnStyle,
                              onPressed: () {},
                              child: const Text("Email"),
                            ),
                          ],
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: const Text("Delete Offer"))
                          ],
                        ),
                      SizedBox(height: Get.height * .2),
                    ],
                  ),
                );
              });
        },
        onEmpty: Constants.empty,
        onLoading: Constants.loading,
        onError: (error) {
          return Container(
            child: const Text("error.toString()"),
          );
        },
      ),
    );
  }

  Widget _buildInitial() {
    if (controller.initial == null) return Container();
    initialOffer ??= controller.initial;
    return Builder(builder: (context) {
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Initial Offer",
                    style: TS.h3,
                  ),
                  const SizedBox(height: 10),
                  _buildChip(
                    "Sender:",
                    " ${initialOffer?.senderId ?? ""}",
                  ),
                  _buildChip(
                    "Message:",
                    " ${initialOffer?.message ?? ""}",
                  ),
                  _buildChip(
                    "Offer Price:",
                    " ${initialOffer?.offerPrice ?? ""}",
                  ),
                  _buildChip(
                    "Has Part:",
                    " ${initialOffer?.hasPart ?? ""}",
                  ),
                  _buildChip(
                    "Logistics:",
                    " ${initialOffer?.logistics ?? ""}",
                  ),
                  _buildChip(
                    "Condition:",
                    " ${initialOffer?.condition ?? ""}",
                  ),
                  _buildChip(
                    "Payment Method:",
                    " ${initialOffer?.paymentMethod ?? ""}",
                  ),
                  _buildChip(
                    "Refund Policy:",
                    " ${initialOffer?.policy ?? ""}",
                  ),
                ],
              ),
            ),
          if (initialOffer == null) m.tile(),
        ],
      );
    });
  }

  Widget _buildChip(String s, String t) {
    return Container(
      decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
          // color: toc.scaffoldBackgroundColor,
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s, style: TS.h4.copyWith(color: toc.textColor.withOpacity(.8))),
          const SizedBox(width: 5),
          Expanded(child: Text(t, style: TS.h3)),
        ],
      ),
    );
  }

  _buildEmpty() {
    return Container(
      padding: Constants.ePadding,
      margin: Constants.ePadding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: toc.cardColor.withOpacity(1),
        borderRadius: Constants.br * 2,
        border: Border.all(color: toc.primaryColor.lighter, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            "This is where you can review the details of the offer, you are able to contact the person making the offer via email or whatsapp. Remember to update the offer status to allow others to make more offers. ",
            style: TS.h4,
          ),
        ],
      ),
    );
  }

  // _buildSender() {
  //   if (initialOffer?.amISender ?? false) return Container();
  //   return Container(
  //     padding: Constants.ePadding,
  //     margin: Constants.ePadding,
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       color: toc.cardColor.withOpacity(1),
  //       borderRadius: Constants.br * 2,
  //       border: Border.all(color: toc.primaryColor.lighter, width: 1.5),
  //     ),
  //     child: Column(
  //       children: [
  //         Text(
  //           "This is a chat that will be populated once you have received a message from the person who you sent the offer.",
  //           style: TS.h4,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
