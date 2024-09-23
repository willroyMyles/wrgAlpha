import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/userinfo.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

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
      rethrow;
    }
  }

  Future<UserInfoModel?> user_getUserById(String id) async {
    try {
      return _fstore.collection(_col).doc(id).get().then((value) {
        if (value.exists) {
          return UserInfoModel.fromMap(value.data()!);
        } else {
          return null;
        }
      });
    } catch (e) {
      print(e);
      return null;
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

  Future<bool> user_updateProfile(Map<String, dynamic> map) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;
      var userDoc = _fstore.collection(_col).doc(user.email);
      await userDoc.update(map);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> user_modifyWatching(String id, {bool add = true}) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;

      var userDoc = _fstore.collection(_col).doc(user.email);
      var postDoc = _fstore.collection("posts").doc(id);
      var res = await _fstore.runTransaction((transaction) async {
        if (add) {
          transaction.update(userDoc, {
            "watching": FieldValue.arrayUnion([id])
          });

          transaction.update(postDoc, {"watching": FieldValue.increment(1)});
          GF<ProfileState>().userModel?.value.watching.add(id);
        } else {
          transaction.update(userDoc, {
            "watching": FieldValue.arrayRemove([id])
          });

          transaction.update(postDoc, {"watching": FieldValue.increment(-1)});
          GF<ProfileState>().userModel?.value.watching.remove(id);
        }
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
