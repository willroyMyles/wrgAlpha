import 'package:flutter/material.dart';

class CustomListView<T> extends StatefulWidget {
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
  State<CustomListView<T>> createState() => _CustomListViewState<T>();
}

class _CustomListViewState<T> extends State<CustomListView<T>>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          // await _.setup();
          if (widget.reset != null) {
            await widget.reset!();
          }
        },
        child: Column(
          children: [
            if (widget.header != null) widget.header!,
            Expanded(
              child: ListView.builder(
                key: UniqueKey(),
                controller: widget.con,
                padding: EdgeInsets.zero,
                itemCount: widget.items.length + (widget.items.isEmpty ? 1 : 0),
                itemBuilder: (context, index) {
                  if (widget.items.isEmpty) {
                    return Container(
                      height: 300,
                      alignment: Alignment.center,
                      child: const Text(
                        "No items found\npull to refresh",
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  var model = widget.items.elementAt(index);

                  if (index == widget.items.length - 1 &&
                      !widget.hasMorePosts) {
                    const SizedBox(
                        height: 100,
                        child: Center(child: Text("No more items")));
                  }
                  return widget.builder(model);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
