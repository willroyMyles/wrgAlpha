import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/model.cars.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

mixin CarsExecutor {
  final _fstore = FirebaseFirestore.instance;
  final _col = "cars";
  Future<bool> cars_addCars(CarModel model) async {
    try {
      model.setId();
      await _fstore.collection(_col).doc(model.id).set(model.toMap());

      return true;
    } catch (e) {
      return false;
    }
  }

  //delete car
  Future<bool> cars_deleteCars(CarModel model) async {
    try {
      await _fstore.collection(_col).doc(model.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cars_updateCars(CarModel model) async {
    try {
      await _fstore.collection(_col).doc(model.id).update(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<CarModel>> cars_getCars() async {
    try {
      var snap = await _fstore
          .collection(_col)
          .where("userEmail",
              isEqualTo: GF<ProfileState>().userModel?.value.email ?? "")
          .get();
      var list = snap.docs.map((e) => CarModel.fromMap(e.data())).toList();
      return list;
    } catch (e) {
      return [];
    }
  }
}
