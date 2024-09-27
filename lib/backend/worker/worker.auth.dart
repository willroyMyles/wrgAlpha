import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
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
        OneSignal.login(user!.value.email!);
        OneSignal.User.addTagWithKey("emailTag", user!.value.email!);
      }
    });
  }
}

AuthWorker _authWorker = AuthWorker();
AuthWorker get authWorker => _authWorker;
