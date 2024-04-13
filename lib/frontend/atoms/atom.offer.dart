import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/widget.extension.dart';

class OffersAtom extends StatelessWidget {
  const OffersAtom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: Get.width / 2.4,
      alignment: Alignment.center,
      child: const Text("You have no Offers"),
    ).card;
  }
}
