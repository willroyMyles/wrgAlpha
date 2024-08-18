import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/models/conversation.dart';
import 'package:wrg2/backend/worker/worker.auth.dart';

class MessagesState extends GetxController with StateMixin {
  RxList<ConversationModel> conversations = <ConversationModel>[].obs;
  Stream<QuerySnapshot<Map<String, dynamic>>>? convoStream;
  bool initialStart = true;
  StreamSubscription? sub;

  @override
  void onInit() {
    super.onInit();
    setup();
  }

  Future setup() async {
    try {
      var myId = authWorker.user!.value.email!;
      // var res = await GF<GE>()
      //     .conversation_getMyConvarsations(authWorker.user!.value.email!);
      // conversations.addAll(res);
      // change("", status: RxStatus.success());

      // if (conversations.isEmpty) {
      //   change("", status: RxStatus.empty());
      // }

      convoStream = FirebaseFirestore.instance
          .collection('conversations')
          .where(Filter.or(Filter("senderId", isEqualTo: myId),
              Filter("recieverId", isEqualTo: myId)))
          .snapshots();
      _startListen();
      change("", status: RxStatus.success());
    } catch (e) {
      change("", status: RxStatus.empty());
    }
  }

  _startListen() {
    sub = convoStream!.listen(_onData);
  }

  var messageCount = 0;
  _onData(QuerySnapshot<Map<String, dynamic>> event) async {
    var data = event.docs;
    if (data.isNotEmpty) {
      for (var datum in data) {
        var convo = ConversationModel.fromMap(datum.data());
        var index =
            conversations.indexWhere((element) => element.id == convo.id);
        if (index == -1) {
          conversations.add(convo);
        } else {
          conversations[index] = convo;
        }
      }
      print("messageCount $messageCount");
    }
    refresh();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    sub?.cancel();
    sub = null;
    convoStream = null;
  }
}
