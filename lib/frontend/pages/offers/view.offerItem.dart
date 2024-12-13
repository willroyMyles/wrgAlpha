import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/messages/detail/view.messageDetails.dart';

class OfferItem extends StatelessWidget {
  final OfferModel model;
  final bool showPost;
  final bool alt;
  const OfferItem(
      {super.key, required this.model, this.showPost = true, this.alt = false});

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
            // horizontal: Constants.cardMargin,
            vertical: alt ? 8 : 0
            // vertical: Constants.cardVerticalMargin / 4,
            ),
        padding: EdgeInsets.all(Constants.cardpadding),
        decoration: BoxDecoration(
          color:
              alt ? toc.scaffoldBackgroundColor.darkerF(0) : Colors.transparent,
          // border: Border.all(
          //   width: 3,
          //   color: toc.scaffoldBackgroundColor.darkerF(20),
          // ),
          borderRadius: Constants.br,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.message.capitalizeFirst!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TS.h2,
                    ),
                    FittedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "from: ",
                            style: TS.h5,
                          ),
                          Text(
                            model.senderId,
                            overflow: TextOverflow.ellipsis,
                            style: TS.h2,
                          )
                        ],
                      ),
                    ),
                    if (model.offerPrice != null)
                      Row(
                        children: [
                          Text(
                            "Offer Price: ",
                            style: TS.h5,
                          ),
                          Text(
                            model.offerPrice!.capitalize!,
                            style: TS.h2,
                          )
                        ],
                      ),
                    if (showPost)
                      Txt(
                        "Post : ${model.postTitle.capitalizeFirst!}",
                        maxLines: 1,
                      ).h4,

                    // const Divider(),
                  ]),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                buildChip(model.status!.name, color: model.status!.color),
                const SizedBox(height: 3),
                // Text(
                //   "tap to view",
                //   style: TS.hint1,
                // ),
              ],
            ),
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
        padding: Constants.ePadding,
        decoration: BoxDecoration(
          border: Border.all(
            width: 0,
            color: toc.scaffoldBackgroundColor.darkerF(20),
          ),
          borderRadius: Constants.br * 2,
          color: toc.cardColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Opacity(
                          opacity: .6,
                          child: Txt("${models.length} Offers for ")),
                      Text(
                        postTitle.capitalizeFirst!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      )
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed("/posts/${models.first.postId}");
                    },
                    child: const Text("View Post"))
              ],
            ),
            const SizedBox(height: 5),
            ...models.map((e) => OfferItem(
                  model: e,
                  showPost: false,
                  alt: true,
                )),
          ],
        ));
  }
}
