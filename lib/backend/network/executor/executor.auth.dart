import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';

mixin AuthExecutor {
  Future user_logout() async {
    try {
      GoogleSignIn().signOut();
      FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();

      // var clientId = GetPlatform.isAndroid
      //     ? "562995348940-f8svrjv49g67mec1hpvl2q67fpq2i8ac.apps.googleusercontent.com"
      //     : "562995348940-f8svrjv49g67mec1hpvl2q67fpq2i8ac.apps.googleusercontent.com";

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: [
          'https://www.googleapis.com/auth/userinfo.email',
          'https://www.googleapis.com/auth/userinfo.profile'
        ],
        hostedDomain: "",
      ).signIn();

      if (googleUser.isNull) {
        //throw cant log in
        return false;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      var cred = await FirebaseAuth.instance.signInWithCredential(credential);
      await registerNewUser(cred);
      return true;
    } catch (error) {
      return false;
    }
    // return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  registerNewUser(UserCredential creds) async {
    await Get.find<GE>().user_registerUserFromCredentials(creds);
  }
}
