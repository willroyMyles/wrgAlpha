import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/widget.extension.dart';

class WatchingAtom extends StatelessWidget {
  const WatchingAtom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: Get.width / 2.4,
      alignment: Alignment.center,
      child: const Text("You're not watching any posts"),
    ).card;
  }
}
