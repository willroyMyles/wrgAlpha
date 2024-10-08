import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/models/model.cars.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/store/sotre.data.dart';
import 'package:wrg2/backend/utils/util.snackbars.dart';
import 'package:wrg2/frontend/pages/post/state.posts.dart';
import 'package:wrg2/frontend/pages/post/state.service.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class CreatePostState extends GetxController {
  RxMap<String, String> model = RxMap({});
  Map<String, TextEditingController> crtls = {};
  RxBool isService = false.obs;

  @override
  void onInit() {
    super.onInit();
    for (var element in ['make', 'model', 'year', 'category', 'sub']) {
      crtls.putIfAbsent(element, () => TextEditingController());
      model[element] = "";
    }

    var arg = Get.arguments?['isService'];
    if (arg != null) {
      isService.value = arg;
    }
  }

  List<String> getMakeList() {
    var makeList = getMake();
    return makeList;
  }

  List<String> getModelList() {
    var makeList = getMake();
    var key = model['make'];

    if (key == null) {
      //throw error
      return [];
    }

    var idx = makeList.indexOf(key);
    var modelList = getModels(idx);
    return modelList;
  }

  List<String> getCategoryList() {
    var category = isService.value ? getServices() : getCategories();
    return category;
  }

  List<String> getSubCategoryList() {
    var category = getCategories();
    var key = model['category'];

    if (key == null) {
      //throw error
      return [];
    }

    var idx = category.indexOf(key);
    var modelList = getSubCategories(idx);
    return modelList;
  }

  bool _validate() {
    if (model['content'] == null || model['content']!.isEmpty) {
      SBUtil.showErrorSnackBar("Content of post must not be empty");

      return false;
    }
    if (model['make'] == null || model['make']!.isEmpty) {
      SBUtil.showErrorSnackBar("Please select make of car to continue");

      return false;
    }
    if (model['model'] == null || model['model']!.isEmpty) {
      SBUtil.showErrorSnackBar("Please select model of car to continue");

      return false;
    }

    return true;
  }

  addCarModel(CarModel carModel) {
    model['make'] = carModel.make;
    model['model'] = carModel.model;
    model['year'] = carModel.year.toString();
    model.refresh();
    refresh();
  }

  onSubmit() async {
    if (!_validate()) {
      //show error
      return;
    }

    PostModel pm = PostModel();

    pm.title = model['title'] ?? "";
    pm.content = model['content'] ?? "";
    pm.make = model['make'] ?? "";
    pm.model = model['model'] ?? "";
    pm.year = num.tryParse(model['year'] ?? "2000")!.toInt();
    pm.category = model['category'] ?? "";

    var user = Get.find<ProfileState>().userModel!.value;
    pm.userEmail = user.email;
    pm.userName = user.username;
    pm.userPhotoUrl = user.userImageUrl;
    pm.createdAt = DateTime.now();
    pm.isService = isService.value;

    var res = await Get.find<GE>().posts_createPost(pm);
    if (res) {
      // show success
      if (isService.value) {
        Get.find<ServiceState>().addPost(pm);
      } else {
        Get.find<PostState>().addPost(pm);
      }
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
