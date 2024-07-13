import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/frontend/atoms/atom.customListVIew.dart';
import 'package:wrg2/frontend/pages/services/state.service.dart';
import 'package:wrg2/frontend/pages/services/tile.service.dart';

class ServiceList extends StatelessWidget {
  ServiceList({super.key});
  final controller = Get.put(ServiceState());

  @override
  Widget build(BuildContext context) {
    return CustomListView(
        header: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Services Wanted",
                style: TS.h3,
              ),
            )
          ],
        ),
        items: controller.posts,
        loadMore: controller.loadMore,
        reset: controller.setup,
        builder: (p0) {
          return ServiceTile(model: p0);
        },
        con: controller.scroll);
  }
}
