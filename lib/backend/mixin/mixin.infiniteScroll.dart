import 'package:flutter/cupertino.dart';
import 'package:get/get_instance/src/lifecycle.dart';

mixin InfiniteScrollMixin on GetLifeCycleBase {
  ScrollController scroll = ScrollController();
  double offset = 100.0;

  @override
  void onInit() {
    super.onInit();
    scroll = ScrollController(
      onAttach: (position) {
        print("attached");
        scroll.addListener(
          () {
            print("listening");
            _listener();
          },
        );
      },
      onDetach: (position) {
        print("object");
      },
    );
  }

  bool _canFetchBottom = true;

  bool _canFetchTop = true;

  void _listener() {
    if (scroll.position.atEdge) {
      _checkIfCanLoadMore();
    }
  }

  Future<void> _checkIfCanLoadMore() async {
    if (scroll.position.pixels == 0) {
      if (!_canFetchTop) return;
      _canFetchTop = false;
      await onTopScroll();
      _canFetchTop = true;
    } else {
      if (!_canFetchBottom) return;
      _canFetchBottom = false;
      await onEndScroll();
      _canFetchBottom = true;
    }
  }

  Future<void> onEndScroll();

  Future<void> onTopScroll();

  @override
  void onClose() {
    scroll.removeListener(_listener);
    super.onClose();
  }
}
