import 'package:flutter/material.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

extension WidgetExt on Widget {
  Widget get card => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              lightBackgroundColor,
              lightBackgroundColor.withOpacity(.5),
              // lightBackgroundColor,
              // lightBackgroundColor.withOpacity(.5),
              // lightBackgroundColor,
              // lightBackgroundColor.withOpacity(.5),
              // lightBackgroundColor,
              // lightBackgroundColor.withOpacity(.5),
              // lightBackgroundColor,
              // lightBackgroundColor.withOpacity(.5),
              // lightBackgroundColor,
              // lightBackgroundColor.withOpacity(.5),
              // lightBackgroundColor,
              // lightBackgroundColor.withOpacity(.5),
              // lightBackgroundColor,
              // lightBackgroundColor.withOpacity(.5),
              // lightBackgroundColor,
              // lightBackgroundColor.withOpacity(.5),
              // lightBackgroundColor,
              // lightBackgroundColor.withOpacity(.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: this,
      );
}

var decoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      lightBackgroundColor.withOpacity(.5),
      lightBackgroundColor.withOpacity(_getFraction()),
      lightBackgroundColor.withOpacity(.5),
    ],
    begin: Alignment.topLeft,
    end: Alignment.topRight,
  ).scale(2.5),
  borderRadius: BorderRadius.circular(5),
  border: Border.all(color: lightBackgroundColor.withOpacity(.5), width: 8),
);

double _getFraction() {
  return .1;
}
