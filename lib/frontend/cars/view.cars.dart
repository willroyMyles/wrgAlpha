import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';
import 'package:wrg2/frontend/cars/state.cars.dart';
import 'package:wrg2/frontend/cars/tile.car.dart';
import 'package:wrg2/frontend/cars/view.addCars.dart';

class CarsView extends StatelessWidget {
  CarsView({super.key});
  var contorller = Get.put(CarState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, b) => [
          WRGAppBar(
            "Your Cars",
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
        body: contorller.obx(
          (state) => RefreshIndicator(
            onRefresh: () async {
              await contorller.setup();
            },
            child: ListView.builder(
              itemCount: contorller.cars.length,
              itemBuilder: (context, index) {
                var item = contorller.cars.elementAt(index);
                return CarTile(car: item);
              },
            ),
          ),
          onEmpty: RefreshIndicator(
            onRefresh: () async {
              await contorller.setup();
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Constants.emptyWidget("No Cars Present",
                      "Tap add button to add your first car"),
                ],
              ),
            ),
          ),
          onLoading: Constants.loading,
        ),
      ),
    );
  }
}
