import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/messages.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.promptHelper.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/messages/detail/state.messageDetails.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class MessageDetailView extends StatelessWidget {
  OfferModel? initialOffer;
  MessageDetailView({super.key, this.initialOffer});
  final controller = Get.put(MessageDetailsState());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: toc.scaffoldBackgroundColor,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: false,
        bottomSheet:
            !(initialOffer?.amISender() ?? false) && controller.messages.isEmpty
                ? BottomSheet(
                    onClosing: () {},
                    builder: (context) => Container(
                      color: toc.scaffoldBackgroundColor,
                      child: SafeArea(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Constants.cardpadding),
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
                  )
                : null,
        appBar: AppBar(
          centerTitle: true,
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Opacity(
              opacity: .6,
              child: Text(
                "You're messages with",
                textScaler: TextScaler.linear(.8),
              ),
            ),
            Text(
                "${(initialOffer?.amISender() ?? false) ? initialOffer?.recieverId : initialOffer?.senderId}"),
          ]),
          bottom: !(initialOffer?.amISender() ?? false)
              ? PreferredSize(
                  preferredSize: Size(Get.width, 50),
                  child: GetBuilder<MessageDetailsState>(
                    init: controller,
                    initState: (_) {},
                    builder: (_) {
                      if (_.initial?.status == OfferStatus.Accepted ||
                          _.initial?.status == OfferStatus.Declined) {
                        return Container(
                          child: Text(
                            "This offer was ${_.initial!.status!.displayName.toLowerCase()}",
                            style: TS.h3.copyWith(color: toc.primaryColor),
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
              : null,
        ),
        body: controller.obx(
          (state) {
            var state = GF<ProfileState>();
            var imSender = (initialOffer?.amISender() ?? false);

            return SingleChildScrollView(
              controller: controller.scroll,
              // physics: const ClampingScrollPhysics(),
              child: Obx(() => Column(
                    children: [
                      SizedBox(height: Constants.cardMargin),
                      _buildInitial(),
                      if (controller.messages.isEmpty && !imSender)
                        _buildEmpty()
                      else
                        _buildSender(),
                      ...controller.messages.map((e) {
                        return e.tile(e == controller.messages.last
                            ? controller.last
                            : null);
                      }),
                      SizedBox(height: Get.height * .2),
                    ],
                  )),
            );
          },
          onEmpty: Constants.empty,
          onLoading: Constants.loading,
        ),
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
                  const Text("initial Offer"),
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
          Text(s, style: TS.h4.copyWith(color: toc.textColor.withOpacity(.7))),
          const SizedBox(width: 5),
          Expanded(child: Text(t, style: TS.h4)),
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
            "Here you can message the person who sent you the offer to discuss details. You can also accept or decline the offer, this will update the original post letting everyone know that your request has been answered. Below is the chat box where you can type and send your message. send your first message to get started. ",
            style: TS.h4,
          ),
        ],
      ),
    );
  }

  _buildSender() {
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
            "This is a chat that will be populated once you have received a message from the person who you sent the offer.",
            style: TS.h4,
          ),
        ],
      ),
    );
  }
}
