import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/model.cars.dart';
import 'package:wrg2/backend/store/store.logos.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/cars/state.cars.dart';
import 'package:wrg2/frontend/cars/view.addCars.dart';

class CarTile extends GetView<CarState> {
  final CarModel car;
  const CarTile({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    var logo = logoHelper.getThumbnail(car.make);
    return Container(
      padding: Constants.ePadding,
      margin: Constants.ePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (logo != null)
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Builder(
                    builder: (context) {
                      return Image.network(
                        logo,
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   car.alias ?? "",
                  //   style: TS.h2,
                  // ),
                  Text(
                    "${car.make} ${car.model} ${car.year}",
                    style: TS.h2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${car.transmission?.name.capitalize}  ",
                        style: TS.h3,
                      ),
                      Text(
                        " ${car.bodyType?.capitalize}  ",
                        style: TS.h3,
                      ),
                      Text(
                        "  ${car.type?.name.capitalize} ",
                        style: TS.h3,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              PopupMenuButton(
                child: const Icon(CupertinoIcons.ellipsis_vertical),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        controller.car.value = car;
                        Get.to(() => ManageCarView(
                              edit: true,
                              car: car,
                            ));
                      },
                      value: "edit",
                      child: const Text("Edit"),
                    ),
                    const PopupMenuItem(
                      value: "delete",
                      child: Text("Delete"),
                    ),
                  ];
                },
              ),
            ],
          ),
          // Constants.verticalSpace,

          Constants.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "${car.engineNo}",
                    style: TS.h2,
                  ),
                  Text(
                    "Engine: ",
                    style: TS.h3,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "${car.chasisNo}",
                    style: TS.h2,
                  ),
                  Text(
                    "Chasis: ",
                    style: TS.h3,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}