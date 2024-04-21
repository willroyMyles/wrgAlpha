import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/widget.extension.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/pages/offers/state.offers.dart';

class OffersAtom extends StatelessWidget {
  const OffersAtom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width / 2.4,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GetBuilder<OfferState>(
            initState: (_) {},
            builder: (_) {
              return Obx(() => Text(_.models.length.toString()));
            },
          ),
          const Opacity(opacity: Constants.opacity, child: Text("Offers")),
        ],
      ),
    ).card;
  }
}
