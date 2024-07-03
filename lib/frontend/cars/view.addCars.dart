import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/models/model.cars.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';
import 'package:wrg2/frontend/cars/state.cars.dart';

class ManageCarView extends GetView<CarState> {
  const ManageCarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, b) => [
          const WRGAppBar(
            "Manage your car",
          ),
        ],
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            padding: Constants.ePadding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildInput("Alias", (v) {
                    controller.car.value.alias = v;
                  }),
                  Row(
                    children: [
                      Expanded(
                        child: buildDropdownInput("Make", (v) {
                          controller.car.value.make = v;
                          controller.car.refresh();
                        }, items: controller.getMake()),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Obx(() => Container(
                              key: UniqueKey(),
                              child: buildDropdownInput("Model", (v) {
                                controller.car.value.model = v;
                              },
                                  initialValue: controller.car.value.model,
                                  items: ["", ...controller.getModelList()]),
                            )),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildDropdownInput(
                          "Year",
                          (v) {
                            controller.car.value.year = v;
                          },
                          items: List.generate(
                              60, (idx) => (2024 - idx).toString()),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: buildInput("Engine No.", (v) {
                        controller.car.value.engineNo = v;
                      })),
                      const SizedBox(width: 10),
                      Expanded(
                          child: buildInput("Chassie No.", (v) {
                        controller.car.value.chasisNo = v;
                      })),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: buildInput("Color", (v) {
                        controller.car.value.color = v;
                      })),
                      const SizedBox(width: 10),
                      Expanded(
                          child: buildInput("Body Type", (v) {
                        controller.car.value.bodyType = v;
                      })),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildDropdownInput("Transmission", (v) {
                          controller.car.value.transmission =
                              Transmission.fromName(v);
                        },
                            items: Transmission.values
                                .map((e) => e.name)
                                .toList()),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildDropdownInput("Car Type", (v) {
                          controller.car.value.type = CarType.fromName(v);
                        }, items: CarType.values.map((e) => e.name).toList()),
                      ),
                    ],
                  ),
                  buildInput("Description", (v) {
                    controller.car.value.description = v;
                  }),
                  const SizedBox(height: 30),
                  TextButton(
                      onPressed: () {
                        controller.addCar();
                      },
                      child: const Text("Submit")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
