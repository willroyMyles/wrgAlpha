import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';
import 'package:wrg2/frontend/pages/post/state.createPost.dart';

class CreatePost extends StatelessWidget {
  CreatePost({super.key});
  final controller = Get.put(CreatePostState());

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
              // CupertinoSliverNavigationBar(
              //   largeTitle: Container(
              //     color: Colors.white,
              //     child: const Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Text("Seek your parts"),
              //         Text(
              //           "post what your looking for",
              //           style: TextStyle(
              //               fontSize: 12, fontWeight: FontWeight.w400),
              //         ),
              //       ],
              //     ),
              //   ),
              //   stretch: false,
              //   transitionBetweenRoutes: true,
              //   alwaysShowMiddle: false,
              //   border: const Border(),
              //   padding: EdgeInsetsDirectional.zero,
              // ),
              const WRGAppBar(
                "Seek your parts",
                additional: "post what parts you're looking for",
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Get.width / divider,
                                    child: buildDropdownInput(
                                      "make",
                                      requireInput: true,
                                      items: [...controller.getMakeList(), ""],
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
                                        initialValue:
                                            controller.model.value['model'] ??
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
                                            controller.model['year'] = val;
                                          },
                                          items: [
                                            "",
                                            ...List.generate(
                                                60,
                                                (idx) =>
                                                    (DateTime.now().year - idx)
                                                        .toString())
                                          ],
                                          tec: controller.crtls['year'],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            space,
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: Get.width / 2.2,
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
                                        tec: controller.crtls['category'],
                                      )),
                                  Obx(() => SizedBox(
                                      key: UniqueKey(),
                                      width: Get.width / 2.2,
                                      child: buildDropdownInput(
                                        "sub category",
                                        (val) {
                                          controller.model['sub'] = val;
                                        },
                                        items: [
                                          ...controller.getSubCategoryList(),
                                          ""
                                        ],
                                        tec: controller.crtls['sub'],
                                        initialValue:
                                            controller.model.value['sub'] ?? "",
                                      ))),
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
