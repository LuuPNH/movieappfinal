import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth? firebaseAuth;

  UserRepository({ this.firebaseAuth});

  Future<void> signInWithCredentials(String email, String password) {
    return firebaseAuth!.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp (String email, String password) {
    return firebaseAuth!.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future signOut() async {
    return Future.wait([firebaseAuth!.signOut()]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await firebaseAuth!.currentUser;
    return currentUser != null ;

  }

  Future<FirebaseAuth> getUser() async {
    return await firebaseAuth!;
  }

}