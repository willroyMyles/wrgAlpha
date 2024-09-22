import 'package:flutter/material.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';

typedef ListViewPageBuilder = Widget Function(int index);

class WrgListViewPage extends StatelessWidget {
  final String label;
  final ListViewPageBuilder builder;

  const WrgListViewPage(
      {super.key, required this.label, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [WRGAppBar(label)];
        },
        body: ListView.builder(
          itemBuilder: (context, index) {
            return builder(index);
          },
        ),
      ),
    );
  }
}
