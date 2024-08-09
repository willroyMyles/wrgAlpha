import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxController {
  var box = GetStorage();
  static const String reduceAnimationKey = "mmja_reduce_animation";

  Future init() async {
    await box.initStorage;
    return true;
  }

  /// Read the value of the key from the storage and return it.
  ///
  /// Args:
  ///   key (String): The key to read from storage.
  readFromStorage(String key) {
    return box.read(key);
  }

  /// Write the value to the box with the given key.
  ///
  /// Args:
  ///   key (String): The key to store the value under.
  ///   value (dynamic): The value to be stored.
  writeToStorage(String key, dynamic value) => box.write(key, value);
}
