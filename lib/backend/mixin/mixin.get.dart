import 'package:get/get.dart';

typedef ItemCreator<S> = S Function();

extension MMJAGet on GetInterface {
  S? findIfRegistered<S>({String? tag}) {
    var registered = GetInstance().isRegistered<S>(tag: tag);
    var prepared = GetInstance().isPrepared<S>(tag: tag);

    try {
      if (registered) {
        var con = GetInstance().find<S>(tag: tag);
        return con;
      }
    } catch (e) {
      return null;
    }

    return null;
  }
}

T GF<T>() => Get.find<T>();
T? GFI<T>() => Get.findIfRegistered<T>();
