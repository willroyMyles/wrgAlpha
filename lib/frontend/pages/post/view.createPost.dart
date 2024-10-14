import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.btns.dart';
import 'package:wrg2/backend/utils/util.formatter.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';
import 'package:wrg2/frontend/atoms/atom.bottomSheet.dart';
import 'package:wrg2/frontend/cars/state.cars.dart';
import 'package:wrg2/frontend/cars/view.addCars.dart';
import 'package:wrg2/frontend/pages/post/state.createPost.dart';

class CreatePost extends StatelessWidget {
  CreatePost({super.key});
  final controller = Get.put(CreatePostState());
  Map<String, TextEditingController> textControllers = {
    "make": TextEditingController(),
    "model": TextEditingController(),
    "year": TextEditingController(),
    "category": TextEditingController(),
  };

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
              Obx(() => WRGAppBar(
                    controller.isService.value
                        ? "Request a service"
                        : "Seek your parts",
                    additional: Text(
                      controller.isService.value
                          ? "Request which service you're looking for"
                          : "post what parts you're looking for",
                      textScaler: const TextScaler.linear(.5),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () async {
                            await Get.bottomSheet(BottomSheetComponent(
                              maxChildSize: .7,
                              builder: (context, scrollController) {
                                return GetBuilder<CarState>(
                                    builder: (carState) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    color: Colors.white,
                                    child: ListView(
                                      controller: scrollController,
                                      children: [
                                        // Text(
                                        //   "Your Cars",
                                        //   style: TS.h2,
                                        // ),
                                        const SizedBox(height: 10),
                                        if (carState.cars.isEmpty)
                                          Container(
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: [
                                                  Constants.emptyWidget(
                                                      "No cars found"),
                                                  TextButton(
                                                      style: BS.defaultBtnStyle,
                                                      onPressed: () {
                                                        Get.to(() =>
                                                            const ManageCarView());
                                                      },
                                                      child:
                                                          const Text("Add Car"))
                                                ],
                                              )),
                                        ...carState.cars.values
                                            .map((e) => ListTile(
                                                  title: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
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
                                });
                              },
                            ));
                          },
                          icon: const Icon(CupertinoIcons.car_detailed))
                    ],
                  ))
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
                              child: GetBuilder<CreatePostState>(
                                  init: controller,
                                  builder: (_) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Obx(() => SizedBox(
                                              key: UniqueKey(),
                                              width: Get.width / divider,
                                              child: buildDropdownInput(
                                                "make",
                                                requireInput: true,
                                                ctrl: textControllers,
                                                items: [
                                                  ...controller.getMakeList(),
                                                  // ""
                                                ],
                                                (val) {
                                                  controller.model['make'] =
                                                      val;
                                                  controller.model['model'] =
                                                      "";
                                                  controller.model.refresh();
                                                  textControllers['make']
                                                      ?.text = val;
                                                  textControllers['model']
                                                      ?.text = "";

                                                  print(val);
                                                },
                                                initialValue:
                                                    controller.model['make'] ??
                                                        "",
                                              ),
                                            )),
                                        Obx(() {
                                          return SizedBox(
                                            key: UniqueKey(),
                                            width: Get.width / divider,
                                            child: buildDropdownInput(
                                              "model",
                                              ctrl: textControllers,
                                              requireInput: true,
                                              (val) {
                                                controller.model['model'] = val;
                                                textControllers['model']?.text =
                                                    val;
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
                                        Obx(() => SizedBox(
                                            width: Get.width / divider,
                                            child: buildDropdownInput(
                                              "year",
                                              (val) {
                                                controller.model['year'] = val;
                                                controller.model.refresh();
                                                textControllers['year']?.text =
                                                    val;
                                              },
                                              requireInput: true,
                                              initialValue: controller
                                                      .model.value['year'] ??
                                                  "",
                                              ctrl: textControllers,
                                              items: [
                                                "",
                                                ...List.generate(
                                                    60,
                                                    (idx) =>
                                                        (DateTime.now().year -
                                                                idx)
                                                            .toString())
                                              ],
                                            )))
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
                                  Obx(() => Expanded(
                                        key: UniqueKey(),
                                        child: buildDropdownInputAhead(
                                          "category",
                                          (val) {
                                            controller.model['category'] = val;
                                            controller.model['sub'] = "";
                                            controller.model.refresh();
                                            textControllers['category']?.text =
                                                val;
                                          },
                                          ctrl: textControllers,
                                          initialValue:
                                              controller.model["category"] ??
                                                  "",
                                          items: [
                                            ...controller.getCategoryList(),
                                            ""
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            space,
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: buildInput("mobile number", (val) {
                                      controller.model['mobile'] = val;

                                      textControllers['mobile']?.text = val;
                                    }, formatter: mobileFormatter),
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
                              style: BS.defaultBtnStyle,
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
