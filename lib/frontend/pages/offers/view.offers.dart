import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: WRGAppBar("hello world"),

      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const CupertinoSliverNavigationBar(
              largeTitle: Text("Your Offers"),
              stretch: true,
              transitionBetweenRoutes: true,
              alwaysShowMiddle: false,
            ),
          ];
        },
        body: Container(),
      ),
    );
  }
}
