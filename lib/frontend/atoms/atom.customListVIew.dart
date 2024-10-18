import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.cdnicons.dart';

enum LoadingStates { Loading, LoadingMore, Ready }

class CustomListView<T> extends StatelessWidget {
  List<T> items;
  bool hasMorePosts;
  Function? loadMore;
  Function? reset;
  Widget Function(T) builder;
  ScrollController? con;
  Widget? header;
  int limit;
  TextButton? actionButton;
  Rx<LoadingStates> state;
  CustomListView(
      {super.key,
      this.items = const [],
      this.hasMorePosts = false,
      required this.state,
      required this.loadMore,
      required this.reset,
      required this.builder,
      this.con,
      this.limit = 20,
      this.header});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() => Column(
            children: [
              Padding(
                padding: EdgeInsets.all(Constants.cardpadding),
                child: Row(
                  children: [
                    if (header != null) header!,
                    const Spacer(),
                    if (reset != null)
                      TextButton(
                          onPressed: () async {
                            if (reset != null) {
                              await reset!();
                            }
                          },
                          child: const Text("refresh"))
                  ],
                ),
              ),
              if (items.isNotEmpty)
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
              if (items.isEmpty && state.value == LoadingStates.Ready)
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () async {
                    if (reset != null) {
                      await reset!();
                    }
                  },
                  child: SingleChildScrollView(
                    child: Container(
                      height: Get.height * .6,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AssetrService.empty.displayl,
                          const SizedBox(height: 10),
                          Text(
                            "No Items Found",
                            style: TS.h1,
                          ),
                          Opacity(
                            opacity: .5,
                            child: Text(
                              "Tap to refresh",
                              style: TS.h2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (actionButton != null) actionButton!,
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              if (state.value == LoadingStates.Loading)
                Container(
                  height: Get.height * .6,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // AssetrService.loading.displayl,
                      const SizedBox(height: 10),
                      Text(
                        "Loading...",
                        style: TS.h1,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              if (state.value == LoadingStates.LoadingMore)
                Container(
                  height: Get.height * .6,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // AssetrService.loading.displayl,
                      const SizedBox(height: 10),
                      Text(
                        "Loading More Items...",
                        style: TS.h1,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
            ],
          )),
    );
  }
}
