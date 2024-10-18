import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/model.cars.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';
import 'package:wrg2/frontend/atoms/atom.customListVIew.dart';
import 'package:wrg2/frontend/cars/state.cars.dart';
import 'package:wrg2/frontend/cars/tile.car.dart';
import 'package:wrg2/frontend/cars/view.addCars.dart';

class CarsView extends StatelessWidget {
  CarsView({super.key});
  var controller = Get.put(CarState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, b) => [
          WRGAppBar(
            "",
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(() => const ManageCarView());
                  },
                  icon: Icon(
                    Icons.add_circle_outline_rounded,
                    color: toc.primaryColor,
                    size: 25,
                  ))
            ],
          ),
        ],
        body: CustomListView<CarModel>(
          state: controller.state,
          builder: (p0) {
            return CarTile(car: p0);
          },
          loadMore: null,
          header: Text(
            "Your Cars",
            style: TS.h1,
          ),
          reset: controller.setup,
        ),
        // body: controller.obx(
        //   (state) => RefreshIndicator(
        //     onRefresh: () async {
        //       await controller.setup();
        //     },
        //     child: ListView.builder(
        //       itemCount: controller.cars.length,
        //       itemBuilder: (context, index) {
        //         var item = controller.cars.values.elementAt(index);
        //         return CarTile(car: item);
        //       },
        //     ),
        //   ),
        //   onEmpty: RefreshIndicator(
        //     onRefresh: () async {
        //       await controller.setup();
        //     },
        //     child: SingleChildScrollView(
        //       child: Container(
        //         height: Get.height * .6,
        //         alignment: Alignment.center,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             AssetrService.empty.displayl,
        //             const SizedBox(height: 10),

        //             Text(
        //               "No Cars Found",
        //               style: TS.h1,
        //             ),
        //             const SizedBox(height: 10),
        //             Text(
        //               "Add a car to easily fill out your car information on forms with a click!",
        //               style: TS.h3,
        //               textAlign: TextAlign.center,
        //             ),
        //             const SizedBox(height: 20),

        //             TextButton(
        //                 style: BS.defaultBtnStyle,
        //                 onPressed: () {
        //                   Get.to(() => const ManageCarView());
        //                 },
        //                 child: const Text("Add Car")),
        //             // Constants.emptyWidget("No Cars Present",
        //             //     "Tap add button to add your first car"),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        //   onLoading: Constants.loading,
        // ),
      ),
    );
  }
}
