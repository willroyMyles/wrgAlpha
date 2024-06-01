import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/utils/Constants.dart';
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
            vertical: alt ? Constants.cardVerticalMargin / 4 : 0
            // vertical: Constants.cardVerticalMargin / 4,
            ),
        padding: EdgeInsets.all(Constants.cardpadding),
        decoration: BoxDecoration(
          color:
              alt ? toc.scaffoldBackgroundColor.darkerF(0) : Colors.transparent,
          border: Border.all(
            width: 3,
            color: toc.scaffoldBackgroundColor.darkerF(20),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(.1),
          //     offset: const Offset(5, 5),
          //     blurRadius: 2,
          //   )
          // ],
          borderRadius: Constants.br * 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt(
                      model.message.capitalizeFirst!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ).h4,
                    if (model.offerPrice != null)
                      Txt("Offer Price: ${model.offerPrice!.capitalizeFirst!}")
                          .h3,
                    if (showPost)
                      Txt(
                        "Post : ${model.postTitle.capitalizeFirst!}",
                        maxLines: 1,
                      ).h4,

                    // const Divider(),
                  ]),
            ),
            Text(
              "view",
              style: TextStyle(
                  fontSize: 15,
                  color: toc.primaryColor.darkerF(5),
                  fontWeight: FontWeight.w500),
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
        padding: Constants.ePadding * 1.2,
        decoration: BoxDecoration(
          // border: Border.all(
          //   width: 3,
          //   color: toc.scaffoldBackgroundColor.darkerF(20),
          // ),
          borderRadius: Constants.br * 3,
          color: toc.scaffoldBackgroundColor.darkerF(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                    opacity: .6, child: Txt("${models.length} Offers for ")),
                Text(
                  postTitle.capitalizeFirst!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                )
              ],
            ),
            const SizedBox(height: 10),
            ...models.map((e) => OfferItem(
                  model: e,
                  showPost: false,
                  alt: true,
                )),
          ],
        ));
  }
}
