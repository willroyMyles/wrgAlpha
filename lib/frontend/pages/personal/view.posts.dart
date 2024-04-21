import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalPosts extends StatelessWidget {
  const PersonalPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: WRGAppBar("hello world"),

      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const CupertinoSliverNavigationBar(
              largeTitle: Text("Your Posts"),
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
