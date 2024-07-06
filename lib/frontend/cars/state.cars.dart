import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/model.cars.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/store/sotre.data.dart';

class CarState extends GetxController with StateMixin {
  RxList<CarModel> cars = RxList();
  Rx<CarModel> car = Rx(CarModel());

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
    }

    change("", status: RxStatus.success());
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
    await GF<GE>().cars_addCars(car.value);
  }
}
