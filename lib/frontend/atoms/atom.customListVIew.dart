import 'package:flutter/material.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/utils/Constants.dart';

mixin ScrollMixinCustom<T extends StatefulWidget> on State<T> {
  final ScrollController scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    scroll.addListener(_listener);
  }

  bool _canFetchBottom = true;

  bool _canFetchTop = true;

  void _listener() {
    if (scroll.position.atEdge) {
      _checkIfCanLoadMore();
    }
  }

  Future<void> _checkIfCanLoadMore() async {
    if (scroll.position.pixels == 0) {
      if (!_canFetchTop) return;
      _canFetchTop = false;
      await onTopScroll();
      _canFetchTop = true;
    } else {
      if (!_canFetchBottom) return;
      _canFetchBottom = false;
      await onEndScroll();
      _canFetchBottom = true;
    }
  }

  Future<void> onEndScroll();

  Future<void> onTopScroll();

  @override
  void dispose() {
    scroll.removeListener(_listener);
    super.dispose();
  }
}

class CustomListView<T> extends StatefulWidget {
  List<T> items;
  Function? loadMore;
  Function? reset;
  Widget Function(T) builder;
  ScrollController? con;
  Widget? header;
  int limit;
  CustomListView(
      {super.key,
      this.items = const [],
      required this.loadMore,
      required this.reset,
      required this.builder,
      this.con,
      this.limit = 20,
      this.header});

  @override
  State<CustomListView<T>> createState() => _CustomListViewState<T>();
}

class _CustomListViewState<T> extends State<CustomListView<T>>
    with ScrollMixinCustom<CustomListView<T>> {
  // TextButton? actionButton;

  bool hasMorePosts = true;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    hasMorePosts = widget.items.length > widget.limit;
    loading = false;
  }

  Future _onPullToRefresh() async {
    setState(() {
      loading = true;
      hasMorePosts = true;
      _canFetchBottom = true;
    });
    await widget.reset!();
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      loading = false;
      hasMorePosts = widget.items.length > widget.limit;
    });
  }

  Future _onLoadMore() async {
    print("loading more");
    setState(() {
      loading = true;
    });

    if (widget.loadMore != null) {
      await widget.loadMore!();
    }
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      loading = false;
      hasMorePosts = widget.items.length > widget.limit;
      _canFetchBottom = hasMorePosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(builder: (context, sp) {
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await _onPullToRefresh();
                },
                child: ListView.builder(
                  controller: scroll,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: widget.items.length + _getAdditionalCount(),
                  itemBuilder: (context, index) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        key: UniqueKey(),
                        children: [
                          if (widget.header != null && index == 0)
                            widget.header!,
                          Builder(builder: (context) {
                            if (widget.items.isEmpty && !loading) {
                              return Container(
                                height: (sp.maxHeight.isFinite
                                        ? sp.maxHeight
                                        : 300) -
                                    (widget.header != null ? 200 : 0),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Constants.emptyWidget("No Items Found"),
                                    const Text("Pull To Refresh"),
                                  ],
                                ),
                              );
                            }

                            if (widget.items.length == index &&
                                !hasMorePosts &&
                                !loading) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "--- No More Items ---",
                                          style: TS.h3,
                                        ),
                                        const Text("Pull To Refresh")
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }

                            if (index >= widget.items.length && loading) {
                              return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: const Text("Loading"));
                            }

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                widget.builder(widget.items.elementAt(index)),
                              ],
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  int _getAdditionalCount() {
    if (loading) return 3;
    if (widget.items.isEmpty) {
      return 1;
    }
    if (!hasMorePosts) {
      return 1;
    }
    return 0;
  }

  @override
  Future<void> onEndScroll() async {
    // if (!_canFetchBottom) return;
    // _canFetchBottom = false;
    _onLoadMore();
  }

  @override
  Future<void> onTopScroll() async {}
}
