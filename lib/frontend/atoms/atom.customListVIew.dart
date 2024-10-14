import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomListView<T> extends StatelessWidget {
  List<T> items;
  bool hasMorePosts;
  Function? loadMore;
  Function? reset;
  Widget Function(T) builder;
  ScrollController? con;
  Widget? header;
  int limit;
  CustomListView(
      {super.key,
      this.items = const [],
      this.hasMorePosts = false,
      required this.loadMore,
      required this.reset,
      required this.builder,
      this.con,
      this.limit = 20,
      this.header});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          if (reset != null) {
            await reset!();
          }
        },
        child: Column(
          children: [
            if (header != null) header!,
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                controller: con,
                itemCount: items.length + (items.isEmpty ? 1 : 0),
                itemBuilder: (context, index) {
                  if (items.isEmpty) {
                    return Container(
                      height: Get.height,
                      alignment: Alignment.center,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No items found\npull to refresh",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 300)
                        ],
                      ),
                    );
                  }

                  var model = items.elementAt(index);

                  if (index == items.length - 1 && !hasMorePosts) {
                    var noMore = const SizedBox(
                        height: 300,
                        child: Column(
                          children: [
                            Spacer(),
                            Text("--- No more items ---"),
                            Spacer(),
                            Spacer(),
                          ],
                        ));

                    return Column(
                      children: [
                        builder(model),
                        noMore,
                      ],
                    );
                  }
                  return builder(model);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
