import 'package:crm_project/src/models/user.dart';
//import 'package:chatapp/views/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DUser? _userfromFirebaseuser(User? user) {
    // ignore: unnecessary_null_comparison
    return user != null ? DUser(uid: user.uid, name: user.displayName, email: user.email) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      late User? firebaseUser = result.user;
      return _userfromFirebaseuser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      late User? firebaseUser = result.user;
      return _userfromFirebaseuser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  
}
