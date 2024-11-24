import 'package:get_storage/get_storage.dart';

class WRGStorage {
  init() async {
    await box.initStorage;

    var ans = box.read("Map");

    if (ans == null) return;
    map = ans;
    print(map);
  }

  Map<String, dynamic> map = {};
  final box = GetStorage("wrg map");

  write(String key, dynamic value) {
    map.update(key, (v) => value, ifAbsent: () => value);
    _save();
  }

  T? read<T>(String key, [T? ifNull]) {
    try {
      var ans = map[key] as T;
      return ans;
    } catch (e) {
      return ifNull;
    }
  }

  _save() {
    // save data to storage
    box.write("Map", map);
  }
}

WRGStorage _storage = WRGStorage();
WRGStorage get Storage => _storage;
