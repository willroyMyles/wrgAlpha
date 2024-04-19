import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: WRGAppBar("hello world"),

      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const CupertinoSliverNavigationBar(
              largeTitle: Text("Your Messages"),
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
