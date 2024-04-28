import 'package:get/get.dart';

class MessagesState extends GetxController with StateMixin {
  @override
  void onInit() {
    super.onInit();
    setup();
  }

  Future setup() async {
    change("", status: RxStatus.empty());
  }
}
