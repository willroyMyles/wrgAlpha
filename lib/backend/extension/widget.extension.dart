import 'package:flutter/material.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

extension WidgetExt on Widget {
  Widget get card => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: lightBackgroundColor,
          // border: Border.all(width: 1, color: lightBackgroundColor.darker),
          borderRadius: BorderRadius.circular(5),
        ),
        child: this,
      );
}
