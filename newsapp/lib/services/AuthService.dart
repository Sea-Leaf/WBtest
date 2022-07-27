import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier{

  Future signIn(String UserEmail, String UserPassword) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: UserEmail.trim(),
          password: UserPassword.trim());
    } on Exception catch (e) {
      print(e);
    }
  }
}