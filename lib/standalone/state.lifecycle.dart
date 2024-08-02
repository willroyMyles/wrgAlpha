import 'package:get/get.dart';
import 'package:wrg2/standalone/shorebird.dart';

class LifeCycleState extends FullLifeCycleController with FullLifeCycleMixin {
  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
    shorebirdChecker.onCheck();
  }
}
