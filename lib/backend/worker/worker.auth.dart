import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/store/store.gm.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class AuthWorker {
  Rx<User>? user;

  init() {}

  AuthWorker() {
    FirebaseAuth.instance.authStateChanges().listen((User? u) {
      if (u == null) {
        print('User is currently signed out!');
        Get.find<ProfileState>().remove();
      } else {
        print('User is signed in!');
        user = u.obs;
        user!.refresh();
        Get.find<ProfileState>().setup();

        Future.delayed(const Duration(seconds: 3), () {
          createUserInFirestore(u);
        });
      }
    });
  }

  createUserInFirestore(User u) {
    var created = gm.getItem("user_created", false);
    if (created) return;

    FirebaseChatCore.instance.createUserInFirestore(
      types.User(
        firstName: u.displayName,
        id: u.uid, // UID from Firebase Authentication
        imageUrl: u.photoURL,
      ),
    );

    gm.saveValue("user_created", true);
  }
}

AuthWorker _authWorker = AuthWorker();
AuthWorker get authWorker => _authWorker;
