import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wrg2/backend/models/conversation.dart';
import 'package:wrg2/backend/models/messages.dart';

mixin MessagesExecutor {
  final _col = "conversations";
  final _fstor = FirebaseFirestore.instance;

  Future<bool> conversation_createConversation(ConversationModel model) async {
    try {
      var res = await _fstor.collection(_col).doc(model.id).set(model.toMap());

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

  Future<bool> conversation_updateConversation(ConversationModel model) async {
    try {
      await _fstor.collection(_col).doc(model.id).update(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> conversation_addMesages(
      MessagesModel model, String conversationId) async {
    try {
      await _fstor.collection(_col).doc(conversationId).update({
        "messages": FieldValue.arrayUnion([model.toMap()])
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
