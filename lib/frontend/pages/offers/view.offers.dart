import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
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
          return [
            const WRGAppBar("Your Offers"),
            SliverAppBar(
              pinned: true,
              toolbarHeight: 50,
              automaticallyImplyLeading: false,
              primary: false,
              backgroundColor: toc.scaffoldBackgroundColor,
              title: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: DefaultTabController(
                  length: 3,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    onTap: (value) {
                      controller.onTabChanged(value);
                    },
                    tabs: [0, 1, 2]
                        .map((e) => Tab(text: controller.indexName(e)))
                        .toList(),
                  ),
                ),
              ),
              centerTitle: true,
            ),
          ];
        },
        body: controller.obx(
          (state) => Obx(() {
            var list = controller.offerMap2[controller.currentIndex.value];

            if (list == null) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Constants.emptyWidget(
                        "No ${controller.indexName(controller.currentIndex.value)}"),
                    Text(
                        "This is where you can find ${controller.currentIndex.value == 0 ? 'Offers made to you' : controller.currentIndex.value == 1 ? 'Offers you made' : controller.currentIndex.value == 2 ? ' offers you sent that was declined by others' : controller.currentIndex.value == 3 ? 'offers' : 'Unknown Offers'}"),
                  ],
                ),
              );
            }
            return GestureDetector(
              onPanUpdate: (details) {
                // // Swiping in right direction.

                // if (details.delta.dx > 2) {
                //   print("right");
                // }

                // // Swiping in left direction.
                // if (details.delta.dx < -2) {
                //   print("${details.delta.dx}");
                // }
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.setup();
                },
                child: ListView.builder(
                  itemCount: list.values.length ?? 0,
                  itemBuilder: (context, index) {
                    var key = list.keys.elementAt(index);
                    var values = list.values.elementAt(index);
                    return OfferBundle(
                        models: values,
                        postTitle: values.firstOrNull?.postTitle ?? "");
                  },
                ),
              ),
            );
          }),
          onEmpty: Constants.emptyWidget("No Offers"),
          onLoading: Constants.loading,
        ),
      ),
    );
  }
}
