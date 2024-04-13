import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderText extends StatelessWidget {
  final String title;
  final String? sub;
  const HeaderText({super.key, required this.title, this.sub});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(title), if (!sub.isNull) Text(sub!)]),
    );
  }
}
