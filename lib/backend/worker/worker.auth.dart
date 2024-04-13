import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wrg2/frontend/profile/state.profile.dart';

class AuthWorker {
  Rx<User>? user;

  init() {}

  AuthWorker() {
    FirebaseAuth.instance.authStateChanges().listen((User? u) {
      if (u == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        user = u.obs;
        user!.refresh();
        Get.find<ProfileState>().setup();
      }
    });
  }
}

AuthWorker _authWorker = AuthWorker();
AuthWorker get authWorker => _authWorker;
