import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/offers/state.offers.dart';

class OffersAtom extends StatelessWidget {
  const OffersAtom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      padding: EdgeInsets.all(Constants.cardpadding),
      decoration: BoxDecoration(
        color: toc.scaffoldBackgroundColor.darker,
        borderRadius: Constants.br,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GetBuilder<OfferState>(
            initState: (_) {},
            builder: (_) {
              return Obx(() => Txt(_.models.length.toString()).h3);
            },
          ),
          Opacity(
              opacity: Constants.opacity,
              child: Txt(
                "Offers".toUpperCase(),
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              )),
        ],
      ),
    );
  }
}
