import 'package:flutter/material.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

extension WidgetExt on Widget {
  Widget get card => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              toc.colorScheme.surface,
              toc.colorScheme.surface.withOpacity(.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: toc.colorScheme.surface.darker, width: 2),
        ),
        child: this,
      );
}

var decoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      toc.colorScheme.surface.withOpacity(.5),
      toc.colorScheme.surface.withOpacity(_getFraction()),
      toc.colorScheme.surface.withOpacity(.5),
    ],
    begin: Alignment.topLeft,
    end: Alignment.topRight,
  ).scale(2.5),
  borderRadius: BorderRadius.circular(5),
  border: Border.all(color: toc.colorScheme.surface.withOpacity(.5), width: 8),
);

double _getFraction() {
  return .1;
}
