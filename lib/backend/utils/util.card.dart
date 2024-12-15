import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

var br = Constants.br;

Widget CardWidget({required Widget child, BoxConstraints? constraints}) {
  return Container(
    constraints: constraints,
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: toc.cardColor,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          // color: toc.scaffoldBackgroundColor.lighterF(0),
          borderRadius: br,
          // border: Border.all(
          //     color: toc.scaffoldBackgroundColor.darkerF(10), width: 2),
        ),
        child: child),
  );
}

CardWidgetBG({required Widget child, BoxConstraints? constraints}) {
  return Container(
    constraints: constraints,
    margin: const EdgeInsets.all(10),
    child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: toc.scaffoldBackgroundColor.lighterF(10),
          borderRadius: br,
          border: Border.all(
              color: toc.scaffoldBackgroundColor.darkerF(10), width: 2),
        ),
        child: child),
  );
}

CardWidgetButton(Widget content, Function onPressed, {double width = .4}) {
  return Container(
    margin: EdgeInsets.only(top: 15),
    child: InkWell(
      onTap: () async {
        onPressed();
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          alignment: Alignment.center,
          width: Get.width * width,
          decoration: BoxDecoration(
            border: Border.all(width: 3, color: toc.textColor.withOpacity(.5)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: content),
    ),
  );
}
