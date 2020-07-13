import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/model/user.dart';
import 'package:flutterapp/screens/authenticade.dart';
import 'package:flutterapp/screens/signIn.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future register(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //return _userFromFireBase(result.user);
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //return _userFromFireBase(result.user);
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future singOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // User _userFromFireBase(FirebaseUser user) {
  //   return user != null ? User(user.uid) : null;
  // }

  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  Future singInAnys() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      // return _userFromFireBase(user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
