import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_shots_mobile/models/user.dart';
import 'package:order_shots_mobile/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  UserNew? _userFromFirebaseUser(User user) {
    // ignore: unnecessary_null_comparison
    if (user != null) {
      return UserNew(uid: user.uid);
    } else {
      return null;
    }
  }

  Stream<UserNew?> get user {
    return _auth.authStateChanges().map((user) {
      return _userFromFirebaseUser(user!);
    });
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // create a new document for the user with the uid
      await DataBaseService(uid: user!.uid).updateUserData("0", "newUser", 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }
}
