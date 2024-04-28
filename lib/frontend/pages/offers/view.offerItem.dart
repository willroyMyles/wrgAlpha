import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/widget.extension.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/pages/messages/detail/view.messageDetails.dart';

class OfferItem extends StatelessWidget {
  final OfferModel model;
  final bool showPost;
  const OfferItem({super.key, required this.model, this.showPost = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Get.to(
            () => MessageDetailView(
                  initialOffer: model,
                ),
            arguments: {"id": model.id, "model": model},
            opaque: false);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Constants.cardMargin,
          // vertical: Constants.cardVerticalMargin / 4,
        ),
        // padding: Constants.ePadding,
        decoration: (card as Container).decoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Txt(model.message.capitalizeFirst!).h2,
              if (showPost)
                Txt(
                  "Post : ${model.postTitle.capitalizeFirst!}",
                  maxLines: 1,
                ).h4,

              // const Divider(),
            ]),
            TextButton(onPressed: () {}, child: const Text("view")),
          ],
        ),
      ),
    );
  }
}

class OfferBundle extends StatelessWidget {
  final List<OfferModel> models;
  final String postTitle;
  const OfferBundle({super.key, required this.models, required this.postTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: Constants.cardMargin,
          vertical: Constants.cardVerticalMargin,
        ),
        // padding: Constants.ePadding,
        decoration: BoxDecoration(
          // border: Border.all(
          //   width: 2,
          //   color: toc.scaffoldBackgroundColor.darkerF(30),
          // ),
          borderRadius: Constants.br,
        ),
        child: Column(
          children: [
            Column(
              children: [
                Opacity(
                    opacity: .6, child: Txt("${models.length} Offers for ")),
                Txt(postTitle.capitalizeFirst!).h3
              ],
            ),
            const Divider(),
            ...models.map((e) => OfferItem(
                  model: e,
                  showPost: false,
                )),
          ],
        ));
  }
}
