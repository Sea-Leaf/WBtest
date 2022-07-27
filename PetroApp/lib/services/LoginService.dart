import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:petroapp/models/user.dart';

class LoginService extends ChangeNotifier {
  LoginUserModel? _userModel;

  LoginUserModel? get loggedInUserModel => _userModel;

  Future<bool> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return false;
    }

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    ) as GoogleAuthCredential;

    UserCredential userCreds =
    await FirebaseAuth.instance.signInWithCredential(credential);
    _userModel = LoginUserModel(
        uid: userCreds.user?.uid,
        DisplayName: userCreds.user?.displayName,
        Email: userCreds.user?.email,
        photoUrl: userCreds.user?.photoURL);

    notifyListeners();
    return true;
  }

  Future<void> signOut() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
    _userModel = null;
  }

  bool isUserLoggedIn() {
    return _userModel != null;
  }
}
