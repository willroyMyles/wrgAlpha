import 'package:get/get.dart';
import 'package:nanoid2/nanoid2.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/conversation.dart';
import 'package:wrg2/backend/models/messages.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/worker/worker.auth.dart';

class MessageDetailsState extends GetxController with StateMixin {
  RxList<MessagesModel> messages = RxList([]);
  ConversationModel? conversation;
  String? messageString;
  OfferModel? initial;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if ((Get.arguments as Map).containsKey("model")) {
      initial = Get.arguments['model'];
    }
    change("", status: RxStatus.success());
  }

  onSend() async {
    if (messages.isEmpty) {
      //create conversation
      var convo = ConversationModel();
      convo.commentId = initial?.id ?? "";
      convo.postId = initial?.postId ?? "";
      convo.recieverId = authWorker.user?.value.email ?? "";
      convo.senderId = initial?.senderId ?? "";

      var m = MessagesModel(
          sender: initial?.senderId ?? "",
          content: initial?.message ?? "",
          id: "initial");

      var mess = MessagesModel(
        sender: authWorker.user?.value.email ?? "",
        content: messageString ?? "",
        id: nanoid(length: 7),
      );

      convo.messages = [m, mess];

      var res = await GF<GE>().conversation_createConversation(convo);
      if (res) {
        messages.add(m);
        messages.add(mess);
        // show success dialouge
        conversation = convo;
      } else {
        // show error dialouge
      }
    } else {
      //add to conversation
      var mess = MessagesModel(
        sender: authWorker.user?.value.email ?? "",
        content: messageString ?? "",
        id: nanoid(length: 7),
      );

      var res = await GF<GE>().conversation_addMesages(mess, conversation!.id);
      if (res) {
        messages.add(mess);
      } else {
        // show error dialouge
      }
    }
  }
}
