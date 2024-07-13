import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';
import 'package:wrg2/frontend/cars/state.cars.dart';
import 'package:wrg2/frontend/pages/services/create/state.createService.dart';

class CreateService extends StatelessWidget {
  CreateService({super.key});
  final controller = Get.put(CreateServicecontroller());

  double divider = 3.4;
  var space = const SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              WRGAppBar(
                "Seek your service",
                additional: const Text(
                  "post what service you're looking for",
                  textScaler: TextScaler.linear(.5),
                ),
                actions: [
                  IconButton(
                      onPressed: () async {
                        await Get.bottomSheet(
                            DraggableScrollableSheet(builder: (context, con) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.white,
                            child: ListView(
                              controller: con,
                              children: [
                                Text(
                                  "Your Cars",
                                  style: TS.h2,
                                ),
                                const SizedBox(height: 10),
                                if (GF<CarState>().cars.isEmpty)
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: const Text("No cars found")),
                                  ),
                                ...GF<CarState>().cars.map((e) => ListTile(
                                      title: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            children: [
                                              Text("${e.year} "),
                                              Text("${e.make} "),
                                              Text(e.model),
                                            ],
                                          )),
                                      onTap: () {
                                        controller.addCarModel(e);
                                        Get.back(result: e);
                                      },
                                    ))
                              ],
                            ),
                          );
                        }));
                      },
                      icon: const Icon(CupertinoIcons.car_detailed))
                ],
              )
            ];
          },
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              child: Container(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(9),
                        margin: const EdgeInsets.all(2),
                        // color: Colors.white,
                        child: Column(
                          children: [
                            space,
                            space,
                            buildInput("title", (val) {
                              controller.model['title'] = val;
                            }),
                            space,
                            buildLargeInput("content", (val) {
                              controller.model['content'] = val;
                            }, height: 180, requireInput: true),
                            space,
                            SizedBox(
                              width: Get.width,
                              child: GetBuilder<CreateServicecontroller>(
                                  init: controller,
                                  builder: (_) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: Get.width / divider,
                                          child: buildDropdownInput(
                                            "make",
                                            requireInput: true,
                                            items: [
                                              ...controller.getMakeList(),
                                              ""
                                            ],
                                            (val) {
                                              controller.model['make'] = val;
                                              controller.model['model'] = "";
                                              controller.model.refresh();
                                            },
                                            initialValue:
                                                controller.model['make'] ?? "",
                                          ),
                                        ),
                                        Obx(() {
                                          return SizedBox(
                                            key: UniqueKey(),
                                            width: Get.width / divider,
                                            child: buildDropdownInput(
                                              "model",
                                              requireInput: true,
                                              (val) {
                                                controller.model['model'] = val;
                                              },
                                              items: [
                                                ...controller.getModelList(),
                                                ""
                                              ],
                                              initialValue: controller
                                                      .model.value['model'] ??
                                                  "",
                                            ),
                                          );
                                        }),
                                        SizedBox(
                                            width: Get.width / divider,
                                            child: SizedBox(
                                              width: Get.width / 2.2,
                                              child: buildDropdownInput(
                                                "year",
                                                (val) {
                                                  controller.model['year'] =
                                                      val;
                                                },
                                                initialValue: controller
                                                        .model.value['year'] ??
                                                    "",
                                                items: [
                                                  "",
                                                  ...List.generate(
                                                      60,
                                                      (idx) =>
                                                          (DateTime.now().year -
                                                                  idx)
                                                              .toString())
                                                ],
                                              ),
                                            ))
                                      ],
                                    );
                                  }),
                            ),
                            space,
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: buildDropdownInput(
                                      "category",
                                      (val) {
                                        controller.model['category'] = val;
                                        controller.model['sub'] = "";
                                        controller.model.refresh();
                                      },
                                      items: [
                                        ...controller.getCategoryList(),
                                        ""
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 5),
                        // child: GroupButton(
                        //   isRadio: false,
                        //   buttons: Tags.values.map((e) => e.name),
                        //   onSelected: (index, isSelected) {
                        //     //should add to selected
                        //   },
                        // )
                      ),
                      Hero(
                        tag: "detail view fab",
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(top: 10),
                          child: TextButton(
                              onPressed: () {
                                // cps.onSubmit();
                                controller.onSubmit();
                              },
                              child: const Text("submit")),
                        ),
                      ),
                      space,
                      space,
                      space,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
