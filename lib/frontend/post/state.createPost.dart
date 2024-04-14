import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/store/sotre.data.dart';
import 'package:wrg2/frontend/atoms/stom.clickList.dart';
import 'package:wrg2/frontend/post/state.posts.dart';
import 'package:wrg2/frontend/profile/state.profile.dart';

class CreatePostState extends GetxController {
  RxMap<String, String> model = RxMap({});
  Map<String, TextEditingController> crtls = {};

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    for (var element in ['make', 'model', 'year', 'category', 'sub']) {
      crtls.putIfAbsent(element, () => TextEditingController());
    }
  }

  void showMake() async {
    var makeList = getMake();
    var ans = await Get.bottomSheet(
      BottomSheet(
        onClosing: () {},
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: .9,
            minChildSize: .4,
            maxChildSize: .9,
            builder: (context, scrollController) {
              return ClickedList(
                list: makeList,
              );
            },
          );
        },
      ),
      isScrollControlled: false,
    );

    if (ans == null) {
      return;
    } else {
      model['make'] = makeList[ans];
      crtls['make']!.text = makeList[ans];
      model.refresh();
      refresh();
    }
  }

  void showModel() async {
    var makeList = getMake();
    var key = model['make'];

    if (key == null) {
      //throw error
      return;
    }

    var idx = makeList.indexOf(key);
    var modelList = getModels(idx);
    var ans = await Get.bottomSheet(
      BottomSheet(
        onClosing: () {},
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: .9,
            minChildSize: .4,
            maxChildSize: .9,
            builder: (context, scrollController) {
              return ClickedList(
                list: modelList,
              );
            },
          );
        },
      ),
      isScrollControlled: false,
    );

    if (ans == null) {
      return;
    } else {
      model['model'] = modelList[ans];
      crtls['model']!.text = modelList[ans];
    }
  }

  void showCatgeory() async {
    var category = getCategories();
    var ans = await Get.bottomSheet(
      BottomSheet(
        onClosing: () {},
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: .9,
            minChildSize: .4,
            maxChildSize: .9,
            builder: (context, scrollController) {
              return ClickedList(
                list: category,
              );
            },
          );
        },
      ),
      isScrollControlled: false,
    );

    if (ans == null) {
      return;
    } else {
      model['category'] = category[ans];
      crtls['category']!.text = category[ans];
      model.refresh();
      refresh();
    }
  }

  void showSubcategory() async {
    var category = getCategories();
    var key = model['category'];

    if (key == null) {
      //throw error
      return;
    }

    var idx = category.indexOf(key);
    var modelList = getSubCategories(idx);
    var ans = await Get.bottomSheet(
      BottomSheet(
        onClosing: () {},
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: .9,
            minChildSize: .4,
            maxChildSize: .9,
            builder: (context, scrollController) {
              return ClickedList(
                list: modelList,
              );
            },
          );
        },
      ),
      isScrollControlled: false,
    );

    if (ans == null) {
      return;
    } else {
      model['sub'] = modelList[ans];
      crtls['sub']!.text = modelList[ans];
    }
  }

  onSubmit() async {
    PostModel pm = PostModel();
    pm.title = model['title'] ?? "";
    pm.content = model['content'] ?? "";
    pm.make = model['make'] ?? "";
    pm.model = model['model'] ?? "";
    pm.year = num.tryParse(model['year'] ?? "2000")!.toInt();
    pm.category = model['category'] ?? "";
    pm.subCategory = model['sub'] ?? "";

    var user = Get.find<ProfileState>().userModel!.value;
    pm.userEmail = user.email;
    pm.userName = user.username;
    pm.userPhotoUrl = user.userImageUrl;

    var res = await Get.find<GE>().posts_createPost(pm);
    if (res) {
      // show success
      Get.find<PostState>().setup();
      Get.back();
    } else {
      //show error
    }
  }

  void setYear(dynamic ans) {
    crtls['year']!.text = ans ?? "";
    model['year'] = ans ?? "";
  }
}
