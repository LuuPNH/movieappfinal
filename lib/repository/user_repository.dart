import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth? _firebaseAuth;

  UserRepository(this._firebaseAuth);

  Future signInWithCredentials(String email, String password) {
    return _firebaseAuth!.signInWithEmailAndPassword(email: email, password: password);
  }

  Future signUp (String email, String password) {
    return _firebaseAuth!.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future signOut() async {
    return Future.wait([_firebaseAuth!.signOut()]);
  }

  Future isSignedIn() async {
    final currentUser = await _firebaseAuth!.currentUser;
    return currentUser != null ;

  }

  Future getUser() async {
    return await _firebaseAuth!.currentUser;
  }

}