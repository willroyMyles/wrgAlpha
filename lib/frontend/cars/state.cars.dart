import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/model.cars.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/store/sotre.data.dart';
import 'package:wrg2/backend/utils/util.snackbars.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class CarState extends GetxController with StateMixin {
  RxList<CarModel> cars = RxList();
  Rx<CarModel> car = Rx(CarModel());

  GlobalObjectKey<FormState> formKey = const GlobalObjectKey("manage car");

  @override
  void onInit() {
    super.onInit();
    setup();
  }

  Future setup() async {
    var c = await GF<GE>().cars_getCars();
    cars.addAll(c);

    if (cars.isEmpty) {
      change("", status: RxStatus.empty());
    } else {
      change("", status: RxStatus.success());
    }
  }

  List<String> getMake() {
    var list = USCars.map((e) => e.first).toList();
    return List<String>.from(list);
  }

  List<String> getModelList() {
    var makeList = getMake();
    var key = car.value.make;

    if (key == "") {
      //throw error
      return [];
    }

    var idx = makeList.indexOf(key);
    var modelList = getModels(idx);
    return modelList;
  }

  void addCar() async {
    if (formKey.currentState?.validate() ?? false) {
      return;
    }
    formKey.currentState?.validate();
    car.value.userEmail = GF<ProfileState>().userModel?.value.email ?? "";
    car.value.userName = GF<ProfileState>().userModel?.value.username ?? "";
    await GF<GE>().cars_addCars(car.value);
    cars.add(car.value);
    change("newState", status: RxStatus.success());
    SBUtil.showSuccessSnackBar("Created car information");
  }

  void updateCar() async {
    await GF<GE>().cars_updateCars(car.value);
    SBUtil.showSuccessSnackBar("Updated car information");
  }
}
