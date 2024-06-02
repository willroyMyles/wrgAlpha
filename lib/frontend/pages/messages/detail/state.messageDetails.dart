import 'dart:async';

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
  ScrollController scroll = ScrollController();
  bool initialStart = true;
  GlobalKey last = GlobalKey();
  StreamSubscription? sub;
  @override
  void onInit() {
    super.onInit();
    setup();
  }

  setup() async {
    try {
      if ((Get.arguments as Map).containsKey("conversation")) {
        conversation = Get.arguments['conversation'];
        var convo =
            await GF<GE>().conversation_getConvarsation(conversation!.id);
        messages.addAll(convo.messages);
        usersStream = FirebaseFirestore.instance
            .collection('conversations')
            .doc(conversation!.id)
            .snapshots();
        _startListen();
        change("", status: RxStatus.success());

        _lastVisible();
        _getInitial();
        return;
      }

      if ((Get.arguments as Map).containsKey("model")) {
        initial = Get.arguments['model'];
      }
      var convo =
          await GF<GE>().conversation_getConvarsationByOfferid(initial!.id);
      conversation = convo;
      if (convo != null) {
        // SBUtil.showErrorSnackBar("Could not get conversation");
        messages.addAll(convo.messages);
      }
      usersStream = FirebaseFirestore.instance
          .collection('conversations')
          .doc(conversation!.id)
          .snapshots();

      _startListen();
      _getInitial();
    } catch (e) {
      if ((Get.arguments as Map).containsKey("model")) {
        initial = Get.arguments['model'];
      }
      _getInitial();
    }
    change("", status: RxStatus.success());
    _lastVisible();
  }

  _getInitial() async {
    if (initial != null) return;
    initial = await GF<GE>().offers_getOfferById(conversation!.offerId);
    refresh();
  }

  _startListen() {
    sub = usersStream!.listen(_onData);
  }

  onAccept() async {}

  onDecline() async {}

  var messageCount = 0;
  _onData(DocumentSnapshot event) async {
    var data = event.data() as Map<String, dynamic>?;
    if (data != null) {
      messageCount++;
      if (initialStart) {
        initialStart = false;
        return;
      }
      List<MessagesModel> mess = List<MessagesModel>.from(
          data['messages'].map((e) => MessagesModel.fromMap(e)).toList());
      messages.add(mess.last);
      messages.refresh();

      _lastVisible();

      print("messageCount $messageCount");
    }
  }

  onSend() async {
    if (messages.isEmpty) {
      //create conversation
      var convo = ConversationModel();
      convo.offerId = initial?.id ?? "";
      convo.postId = initial?.postId ?? "";
      convo.recieverId = authWorker.user?.value.email ?? "";
      convo.senderId = initial?.senderId ?? "";

      convo.postTitle = initial?.postTitle ?? "";
      convo.newMessage = controller.text;

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
        // messages.add(mess);
        controller.clear();
      } else {
        // show error dialouge
      }
    }

    refresh();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    sub?.cancel();
    sub = null;
    usersStream = null;
    scroll.dispose();
  }

  void _lastVisible() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (last.currentContext == null) return;
      Scrollable.ensureVisible(last.currentContext!,
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    });
  }
}
