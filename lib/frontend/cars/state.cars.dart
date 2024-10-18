import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/model.cars.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/store/sotre.data.dart';
import 'package:wrg2/backend/utils/util.promptHelper.dart';
import 'package:wrg2/backend/utils/util.snackbars.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class CarState extends GetxController with StateMixin {
  RxMap<String, CarModel> cars = RxMap({});
  Rx<CarModel> car = Rx(CarModel());
  @override
  bool firstRun = true;

  final formKey = GlobalKey<FormBuilderState>();

  @override
  void onInit() {
    super.onInit();
    setup();
  }

  setup() async {
    if (firstRun) {
      firstRun = false;
      await Future.delayed(const Duration(seconds: 2));
    }
    var c = await GF<GE>().cars_getCars();
    cars.clear();
    cars.addAll({for (var e in c) e.id: e});

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

  void setMake(String str) {
    car.value.make = str;
    car.value.model = "";
    formKey.currentState!.fields["Make"]!.setValue(str);
    car.refresh();
  }

  void setModel(String str) {
    car.value.model = str;
    formKey.currentState!.fields["Model"]!.setValue(str);
    car.refresh();
  }

  void setYear(String str) {
    car.value.year = str;
    formKey.currentState!.fields["Year"]!.setValue(str);
    car.refresh();
  }

  void setTransmission(Transmission v) {
    car.value.transmission = v;
    car.refresh();
  }

  void setEngineGas(CarType type) {
    car.value.type = type;
    car.refresh();
  }

  void addCar() async {
    formKey.currentState?.validate();
    var errors = formKey.currentState?.errors;
    if (errors != null && errors.keys.isNotEmpty) {
      var str = errors.values.reduce((a, b) => "$a\n$b");
      for (var e in errors.keys) {
        formKey.currentState!.fields[e]!.reset();
      }
      SBUtil.showErrorSnackBar(str);
      return;
    }

    car.value.userEmail = GF<ProfileState>().userModel?.value.email ?? "";
    car.value.userName = GF<ProfileState>().userModel?.value.username ?? "";
    await GF<GE>().cars_addCars(car.value);
    cars.update(car.value.id, (value) => car.value, ifAbsent: () => car.value);
    change("newState", status: RxStatus.success());
    Get.back();
    SBUtil.showSuccessSnackBar("Created car information");
    car.value = CarModel();
    // formKey.currentState?.fields.clear();
  }

  void updateCar() async {
    var res = await GF<GE>().cars_updateCars(car.value);
    if (res) {
      cars.refresh();
      Get.back();
      SBUtil.showSuccessSnackBar("Updated car information");
      cars.update(car.value.id, (v) => car.value);
      car.value = CarModel();
      refresh();
    } else {
      SBUtil.showErrorSnackBar("Failed to update car information");
    }
  }

  void removeCar(CarModel carModel) async {
    var ans = await showBinaryPrompt("This cannot be undone",
        title: "Confirm Delete?");
    if (ans) {
      var res = await GF<GE>().cars_deleteCars(carModel);
      if (res) {
        cars.remove(carModel.id);
        cars.refresh();
        refresh();
        SBUtil.showSuccessSnackBar("Car Successfully Deleted");
        if (cars.isEmpty) change("", status: RxStatus.empty());
      } else {
        SBUtil.showErrorSnackBar("Failed to delete car");
      }
    }
  }

  void refreshCar() {
    WidgetsBinding.instance.addPostFrameCallback((v) {
      car.refresh();
    });
  }
}
