import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

showWrgBottomSheet(Widget child) async {
  await Get.bottomSheet(BottomSheet(
    onClosing: () {},
    builder: (context) {
      return Container(
        color: toc.scaffoldBackgroundColor,
        child: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: Constants.br,
                  color: toc.scaffoldBackgroundColor),
              // alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  horizontal: Constants.cardpadding,
                  vertical: Constants.cardVerticalMargin),
              child: child),
        ),
      );
    },
  ));
}
