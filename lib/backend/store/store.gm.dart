// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/store/store.storage.dart';

class GlobalMap extends GetxController with GetTickerProviderStateMixin {
  late RxMap<String, dynamic> map;

  test() {
    //here to start the global map;
  }

  T getItem<T>(String key, T ifNull) {
    try {
      var keyInternal = key.trim();
      if (map.containsKey(keyInternal)) {
        return map[keyInternal];
      } else {
        saveValue(keyInternal, ifNull);
        return ifNull;
      }
    } catch (e) {
      // if (!isTest) {
      //   bugsnag.notify(e, StackTrace.fromString("Could not get item $key"));
      // }
      return ifNull;
    }
  }

  saveValue(String key, dynamic val) {
    try {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        map.update(
          key.trim(),
          (value) => val,
          ifAbsent: () => val,
        );

        _save();
      });
    } catch (e) {
      rethrow;
    }
  }

  _save() {
    GF<StorageService>().writeToStorage("wrgmap", toJson());
    refresh();
  }

  Map<String, dynamic>? _restore() {
    try {
      var str = GF<StorageService>().readFromStorage("wrgmap");
      if (str == null) {
        return {};
      }
      var storageMap = jsonDecode(str);
      var m = storageMap['map'];
      return m;
    } catch (e) {
      return null;
    }
  }

  GlobalMap() {
    var m = _restore();
    if (m != null) {
      map = m.obs;
    } else {
      map = RxMap();
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'map': map,
    };
  }

  factory GlobalMap.fromMap(Map<String, dynamic> map) {
    var m = GlobalMap();
    m.map = RxMap<String, dynamic>.from((map['map'] as Map<String, dynamic>));
    return m;
  }

  String toJson() => json.encode(toMap());

  factory GlobalMap.fromJson(String source) =>
      GlobalMap.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  int get hashCode => map.hashCode;

  clear() {
    map.clear();
    _save();
  }
}

// GlobalMap _globalMap = GlobalMap(map: RxMap());
GlobalMap get gm => Get.find<GlobalMap>();
