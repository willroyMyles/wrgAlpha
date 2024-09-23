import 'package:flutter/material.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';

class WRGScaffold extends StatelessWidget {
  final Widget? child;
  final WRGAppBar? appbar;
  const WRGScaffold({super.key, this.child, this.appbar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            if (appbar != null) appbar!,
          ];
        },
        body: Container(
          child: child,
        ),
      ),
    );
  }
}
