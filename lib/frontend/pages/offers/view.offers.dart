import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';
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
          return [const WRGAppBar("Your Offers")];
        },
        body: controller.obx(
          (state) => ListView.builder(
            itemCount: controller.offerMap.keys.length,
            itemBuilder: (context, index) {
              var key = controller.offerMap.keys.elementAt(index);
              var values = controller.offerMap.value[key] ?? [];
              return OfferBundle(
                  models: values,
                  postTitle: values.firstOrNull?.postTitle ?? "");
            },
          ),
          onEmpty: Constants.empty,
          onLoading: Constants.loading,
        ),
      ),
    );
  }
}
