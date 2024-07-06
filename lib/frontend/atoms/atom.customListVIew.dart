import 'package:flutter/material.dart';

class CustomListView<T> extends StatelessWidget {
  List<T> items;
  bool hasMorePosts;
  Function? loadMore;
  Function? reset;
  Widget Function(T) builder;
  ScrollController? con;
  Widget? header;
  CustomListView(
      {super.key,
      this.items = const [],
      this.hasMorePosts = false,
      required this.loadMore,
      required this.reset,
      required this.builder,
      this.con,
      this.header});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // await _.setup();
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
              itemCount: items.length + (items.isEmpty ? 1 : 0),
              itemBuilder: (context, index) {
                if (items.isEmpty) {
                  return Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: const Text(
                      "No items found\npull to refresh",
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                var model = items.elementAt(index);

                if (index == items.length - 1 && !hasMorePosts) {
                  const SizedBox(
                      height: 100, child: Center(child: Text("No more items")));
                }
                return builder(model);
              },
            ),
          ),
        ],
      ),
    );
  }
}
