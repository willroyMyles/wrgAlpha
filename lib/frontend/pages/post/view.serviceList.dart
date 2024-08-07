import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/frontend/atoms/atom.customListVIew.dart';
import 'package:wrg2/frontend/pages/post/state.service.dart';
import 'package:wrg2/frontend/pages/post/view.postItem.dart';

class ServiceList extends StatelessWidget {
  const ServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceState>(
      initState: (_) {},
      builder: (_) {
        return CustomListView(
            loadMore: _.loadMore,
            reset: _.setup,
            header: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Services Wanted",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
            builder: (model) {
              var index = _.list.indexOf(model);

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                    tag: model.id,
                    child: Material(
                        color: Colors.transparent,
                        child: PostItem(model: model)),
                  ),
                  if (_.noMorePosts.value && index == _.list.length - 1)
                    const SizedBox(
                        height: 250,
                        child: Column(
                          children: [
                            Spacer(),
                            Text("--- No More Items Available ---"),
                            Spacer(),
                            Spacer(),
                          ],
                        )),
                ],
              );
            },
            items: _.list,
            hasMorePosts: !_.noMorePosts.value,
            con: _.scroll);
      },
    );
  }
}
