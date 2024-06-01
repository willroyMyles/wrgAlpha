import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClickedList extends StatelessWidget {
  final List<String> list;
  const ClickedList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          // const SliverAppBar(
          //   automaticallyImplyLeading: false,
          //   title: Text("select make"),
          //   centerTitle: false,
          //   pinned: true,
          // ),
          SliverToBoxAdapter(
            child: Wrap(
              children: [
                ...list.mapIndexed((idx, e) {
                  return InkWell(
                    onTap: () {
                      Get.back(result: idx);
                    },
                    child: Container(
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 2, color: Colors.grey),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.grey.withOpacity(.13))
                          ]),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 33, vertical: 10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            e,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
