import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wrg2/backend/models/userinfo.dart';

mixin UserExecutor {
  final _fstore = FirebaseFirestore.instance;
  final String _col = "user";

  Future user_registerUserFromCredentials(UserCredential creds) async {
    try {
      var user = UserInfoModel();
      user.email = creds.user?.email ?? "";
      user.userId = creds.user?.uid ?? "";
      user.userImageUrl = creds.user?.photoURL ?? "";
      user.username = creds.user?.displayName ?? "";

      var doc = await _fstore.collection(_col).doc(user.email).get();
      if (!doc.exists) {
        await _fstore.collection(_col).doc(user.email).set(user.toMap());
      }
    } catch (e) {
      //throw error
      print(e);
    }
  }

  Future<UserInfoModel?> user_getUser() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;
      var model = await _fstore.collection(_col).doc(user.email).get();
      if (!model.exists) return null;
      var info = UserInfoModel.fromMap(model.data()!);
      return info;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
