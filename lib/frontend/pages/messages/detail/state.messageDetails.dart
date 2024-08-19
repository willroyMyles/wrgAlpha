import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nanoid2/nanoid2.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/conversation.dart';
import 'package:wrg2/backend/models/messages.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/utils/util.snackbars.dart';
import 'package:wrg2/backend/worker/worker.auth.dart';
import 'package:wrg2/frontend/pages/messages/state.messages.dart';

class MessageDetailsState extends GetxController with StateMixin {
  ConversationModel? conversation;
  String? messageString;
  OfferModel? initial;
  TextEditingController controller = TextEditingController();

  ScrollController scroll = ScrollController();
  bool initialStart = true;
  GlobalKey last = GlobalKey();
  StreamSubscription? sub;

  @override
  void onInit() async {
    super.onInit();
    await setup();
  }

  Future setup() async {
    try {
      if ((Get.arguments as Map).containsKey("conversation")) {
        conversation = Get.arguments['conversation'];

        _startListen();
        await _getInitial(id: conversation!.offerId);
        _lastVisible();
        change("", status: RxStatus.success());

        return;
      }

      if ((Get.arguments as Map).containsKey("model")) {
        initial = Get.arguments['model'];
      }

      //below is null because no conversation is here as yet
      var state = Get.put(MessagesState());
      await Future.delayed(const Duration(milliseconds: 250));
      conversation = state.conversations
          .firstWhereOrNull(((e) => e.offerId == initial!.id));

      _getInitial();
      change("", status: RxStatus.success());
    } catch (e) {
      if ((Get.arguments as Map).containsKey("model")) {
        initial = Get.arguments['model'];
      }
      _getInitial();
    }
    change("", status: RxStatus.success());
    _lastVisible();
  }

  _getInitial({String? id}) async {
    if (initial != null) return;
    initial = await GF<GE>().offers_getOfferById(id ?? conversation!.offerId);
    change("", status: RxStatus.success());
    refresh();
  }

  _startListen() {
    // sub = usersStream!.listen(_onData);
  }

  onAccept() async {
    var res = await GF<GE>().offer_acceptOffer(initial!.id, initial!.postId);
    if (res) {
      SBUtil.showSuccessSnackBar("Offer Accepted");
    } else {
      SBUtil.showErrorSnackBar("Could not accept offer, try again");
    }
  }

  onDecline() async {
    var res = await GF<GE>().offer_declineOffer(initial!.id);
    if (res) {
      SBUtil.showSuccessSnackBar("Offer Declined");
    } else {
      SBUtil.showErrorSnackBar("Could not decline offer, try again");
    }
  }

  onSend() async {
    if (false) {
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
      conversation?.messages.add(m);
      conversation?.messages.add(mess);

      var res = await GF<GE>().conversation_createConversation(convo);
      if (res) {
        // messages.add(m);
        // messages.add(mess);
        // show success dialouge
        conversation = convo;
        controller.clear();
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

      var res = await GF<GE>().conversation_addMesages(mess, conversation!.id,
          authWorker.user?.value.email == conversation!.senderId);
      if (res) {
        // messages.add(mess);
        conversation?.messages.add(mess);
        controller.clear();
        _lastVisible();
      } else {
        // show error dialouge
      }
    }

    refresh();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    checkCount();

    super.onClose();
    sub?.cancel();
    sub = null;
    scroll.dispose();
  }

  void _lastVisible() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (last.currentContext == null) return;
      Scrollable.ensureVisible(last.currentContext!,
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    });
  }

  checkCount() {
    if (conversation!.iAmSender) {
      if (conversation!.senderMessageCount > 0) {
        GF<GE>().conversation_removeCount(conversation!.id, true);
      }
    } else {
      if (conversation!.recieverMessageCount > 0) {
        GF<GE>().conversation_removeCount(conversation!.id, false);
      }
    }
  }

  void ensureVisible() {
    _lastVisible();
  }
}
