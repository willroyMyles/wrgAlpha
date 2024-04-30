import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/conversation.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/worker/worker.auth.dart';

class MessagesState extends GetxController with StateMixin {
  RxList<ConversationModel> conversations = <ConversationModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    setup();
  }

  Future setup() async {
    try {
      var res = await GF<GE>()
          .conversation_getMyConvarsations(authWorker.user!.value.email!);
      conversations.addAll(res);
      change("", status: RxStatus.success());

      if (conversations.isEmpty) {
        change("", status: RxStatus.empty());
      }
    } catch (e) {
      change("", status: RxStatus.empty());
    }
  }
}
