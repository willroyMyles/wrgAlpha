import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/pages/offers/state.offers.dart';
import 'package:wrg2/frontend/pages/offers/view.offerItem.dart';

class OffersView extends GetView<OfferState> {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: WRGAppBar("hello world"),

      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const CupertinoSliverNavigationBar(
              largeTitle: Text("Your Offers"),
              stretch: true,
              transitionBetweenRoutes: true,
              alwaysShowMiddle: false,
              border: Border(),
            ),
          ];
        },
        body: controller.obx(
          (state) => Container(
            child: ListView.builder(
              itemCount: controller.offerMap.keys.length,
              itemBuilder: (context, index) {
                var key = controller.offerMap.keys.elementAt(index);
                var values = controller.offerMap[key] ?? [];
                return OfferBundle(
                    models: values,
                    postTitle: values.firstOrNull?.postTitle ?? "");
              },
            ),
          ),
          onEmpty: Constants.empty,
          onLoading: Constants.loading,
        ),
      ),
    );
  }
}
