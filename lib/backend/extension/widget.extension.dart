import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget get card => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: this,
      );
}
