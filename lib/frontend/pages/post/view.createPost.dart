import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: const FlexibleSpaceBar(),
          elevation: 0,
        ),
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 9),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Seek your parts".capitalize!,
                        style: const TextStyle(fontSize: 35),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 9),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "post what your looking for".capitalize!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
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
                          buildInput("content", (val) {
                            controller.model['content'] = val;
                          }, height: 180),
                          space,
                          SizedBox(
                            width: Get.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width / divider,
                                  child: InkWell(
                                    onTap: () async {
                                      // cps.showMake();
                                      controller.showMake();
                                    },
                                    child: IgnorePointer(
                                      child: buildInput(
                                        "make",
                                        (val) {},
                                        tec: controller.crtls['make'],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width / divider,
                                  child: InkWell(
                                    onTap: () async {
                                      // cps.showMake();
                                      controller.showModel();
                                    },
                                    child: IgnorePointer(
                                      child: buildInput(
                                        "model",
                                        (val) {},
                                        tec: controller.crtls['model'],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: Get.width / divider,
                                    child: InkWell(
                                      onTap: () async {
                                        var ans = await Get.dialog(
                                          Container(
                                            height: 330,
                                            width: Get.width,
                                            alignment: Alignment.center,
                                            child: Material(
                                              color: Colors.grey,
                                              child: YearPicker(
                                                firstDate: DateTime.now()
                                                    .subtract(const Duration(
                                                        days: 365 * 50)),
                                                lastDate: DateTime.now().add(
                                                    const Duration(
                                                        days: 365 * 2)),
                                                selectedDate: DateTime.now(),
                                                onChanged: (value) {
                                                  // cps.setYear(value);
                                                  controller.setYear(
                                                      value.year.toString());
                                                  Get.close(1);
                                                },
                                                currentDate: DateTime.now(),
                                                initialDate: DateTime.now(),
                                              ),
                                            ),
                                          ),
                                          barrierColor:
                                              Colors.black.withOpacity(.4),
                                        );
                                      },
                                      child: IgnorePointer(
                                        child: SizedBox(
                                          width: Get.width / 2.2,
                                          child: buildInput(
                                            "year",
                                            (val) {},
                                            tec: controller.crtls['year'],
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          space,
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    // cps.showCat();
                                    controller.showCatgeory();
                                  },
                                  child: IgnorePointer(
                                    child: SizedBox(
                                        width: Get.width / 2.2,
                                        child: buildInput(
                                          "category",
                                          (val) {},
                                          tec: controller.crtls['category'],
                                        )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    // cps.showCat();
                                    controller.showSubcategory();
                                  },
                                  child: IgnorePointer(
                                    child: SizedBox(
                                        width: Get.width / 2.2,
                                        child: buildInput(
                                          "sub category",
                                          (val) {},
                                          tec: controller.crtls['sub'],
                                        )),
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
        ));
  }
}
