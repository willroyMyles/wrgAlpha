import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wrg2/backend/models/conversation.dart';
import 'package:wrg2/backend/models/messages.dart';

mixin MessagesExecutor {
  final _col = "conversations";
  final _fstor = FirebaseFirestore.instance;

  Future<bool> conversation_createConversation(ConversationModel model) async {
    try {
      await _fstor.collection(_col).doc(model.id).set(model.toMap());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<ConversationModel> conversation_getConvarsation(String id) async {
    try {
      var res = await _fstor.collection(_col).doc(id).get();
      return ConversationModel.fromMap(res.data()!);
    } catch (e) {
      return ConversationModel();
    }
  }

  Future<List<ConversationModel>> conversation_getMyConvarsations(
      String myId) async {
    try {
      var res = await _fstor
          .collection(_col)
          .where(Filter.or(Filter("senderId", isEqualTo: myId),
              Filter("recieverId", isEqualTo: myId)))
          .get();
      return res.docs.map((e) => ConversationModel.fromMap(e.data())).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<ConversationModel?> conversation_getConvarsationByOfferid(
      String id) async {
    try {
      var res =
          await _fstor.collection(_col).where("offerId", isEqualTo: id).get();
      return ConversationModel.fromMap(res.docs.first.data());
    } catch (e) {
      return null;
    }
  }

  Future<bool> conversation_updateConversation(ConversationModel model) async {
    try {
      await _fstor.collection(_col).doc(model.id).update(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future conversation_removeCount(String converstionId, bool iAmSender) async {
    Map<Object, Object?> m = {};
    if (iAmSender) {
      m = {
        "senderMessageCount": 0,
      };
    } else {
      m = {
        "recieverMessageCount": 0,
      };
    }

    await _fstor.collection(_col).doc(converstionId).update(m);
  }

  Future<bool> conversation_addMesages(
      MessagesModel model, String conversationId, bool iAmSender) async {
    try {
      await _fstor.collection(_col).doc(conversationId).update({
        "messages": FieldValue.arrayUnion([model.toMap()])
      });

      Map<Object, Object?> m = {};
      if (iAmSender) {
        m = {
          "recieverMessageCount": FieldValue.increment(1),
          "lastMessage": DateTime.now().millisecondsSinceEpoch,
        };
      } else {
        m = {
          "senderMessageCount": FieldValue.increment(1),
          "lastMessage": DateTime.now().millisecondsSinceEpoch,
        };
      }

      await _fstor.collection(_col).doc(conversationId).update(m);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
