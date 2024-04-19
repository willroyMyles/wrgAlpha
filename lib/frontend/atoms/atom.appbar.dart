import 'package:flutter/material.dart';

class WRGAppBar extends AppBar {
  final String text;
  WRGAppBar(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 200,
      flexibleSpace: const FlexibleSpaceBar(
        background: Text("Hello world"),
      ),
    );
  }
}
