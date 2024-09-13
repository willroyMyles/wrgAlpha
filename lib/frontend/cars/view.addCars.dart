import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/models/model.cars.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';
import 'package:wrg2/frontend/cars/state.cars.dart';

class ManageCarView extends GetView<CarState> {
  final bool edit;
  final CarModel? car;

  const ManageCarView({super.key, this.edit = false, this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, b) => [
          WRGAppBar(
            "Manage your car",
            onBackPressed: () {
              controller.car = CarModel().obs;
            },
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
                  }, initialValue: car?.alias),
                  Constants.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: buildDropdownInput("Make", (v) {
                          controller.car.value.make = v;
                          controller.car.refresh();
                        },
                            items: controller.getMake(),
                            initialValue: car?.make),
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
                          initialValue: controller.car.value.year,
                          items: [
                            "",
                            ...List.generate(
                                60, (idx) => (2024 - idx).toString())
                          ],
                        ),
                      ),
                    ],
                  ),
                  Constants.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                          child: buildInput("Engine No.", (v) {
                        controller.car.value.engineNo = v;
                      }, initialValue: controller.car.value.chasisNo)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: buildInput("Chassie No.", (v) {
                        controller.car.value.chasisNo = v;
                      }, initialValue: controller.car.value.chasisNo)),
                    ],
                  ),
                  Constants.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                          child: buildInput("Color", (v) {
                        controller.car.value.color = v;
                      }, initialValue: controller.car.value.color)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: buildInput("Body", (v) {
                        controller.car.value.bodyType = v;
                      }, initialValue: controller.car.value.bodyType)),
                    ],
                  ),
                  Constants.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: buildDropdownInput("Transmission", (v) {
                          controller.car.value.transmission =
                              Transmission.fromName(v);
                        },
                            initialValue:
                                controller.car.value.transmission?.name,
                            items: Transmission.values
                                .map((e) => e.name)
                                .toList()),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildDropdownInput("Engine", (v) {
                          controller.car.value.type = CarType.fromName(v);
                        },
                            items: CarType.values.map((e) => e.name).toList(),
                            initialValue: controller.car.value.type?.name),
                      ),
                    ],
                  ),
                  Constants.verticalSpace,
                  buildInput("Description", (v) {
                    controller.car.value.description = v;
                  }, initialValue: controller.car.value.description),
                  const SizedBox(height: 30),
                  Constants.verticalSpace,
                  if (edit)
                    TextButton(
                        onPressed: () {
                          controller.updateCar();
                        },
                        child: const Text("Update"))
                  else
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
