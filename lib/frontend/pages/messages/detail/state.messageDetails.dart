import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
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
  TextEditingController controller = TextEditingController();

  Stream<DocumentSnapshot>? usersStream;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setup();
  }

  setup() async {
    try {
      if ((Get.arguments as Map).containsKey("conversation")) {
        conversation = Get.arguments['conversation'];
        messages.addAll(conversation!.messages);
        change("", status: RxStatus.success());
        usersStream = FirebaseFirestore.instance
            .collection('conversation')
            .doc(conversation!.id)
            .snapshots();

        return;
      }
      if ((Get.arguments as Map).containsKey("model")) {
        initial = Get.arguments['model'];
      }
      var convo =
          await GF<GE>().conversation_getConvarsationByOfferid(initial!.id);
      conversation = convo;
      messages.addAll(convo.messages);
      usersStream = FirebaseFirestore.instance
          .collection('conversation')
          .doc(conversation!.id)
          .snapshots();
    } catch (e) {
      if ((Get.arguments as Map).containsKey("model")) {
        initial = Get.arguments['model'];
      }
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
        content: controller.text,
        id: nanoid(length: 7),
      );

      convo.messages = [m, mess];

      var res = await GF<GE>().conversation_createConversation(convo);
      if (res) {
        messages.add(m);
        messages.add(mess);
        // show success dialouge
        conversation = convo;
        controller.clear();
        usersStream = FirebaseFirestore.instance
            .collection('conversation')
            .doc(conversation!.id)
            .snapshots();
      } else {
        // show error dialouge
      }
    } else {
      //add to conversation
      var mess = MessagesModel(
        sender: authWorker.user?.value.email ?? "",
        content: controller.text,
        id: nanoid(length: 7),
      );

      var res = await GF<GE>().conversation_addMesages(mess, conversation!.id);
      if (res) {
        messages.add(mess);
        controller.clear();
      } else {
        // show error dialouge
      }
    }

    refresh();
  }
}
