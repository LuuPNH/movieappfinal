import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' hide UserInfo;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:movieappfinal/local_data_manager/local_data_manager.dart';
import 'package:movieappfinal/model/user.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginGGEvent>(_onAddLoginGG);
  }

  Future<void> _onAddLoginGG(
      LoginGGEvent event, Emitter<LoginState> emit) async {
    try {
      final _googleSignIn = GoogleSignIn();

      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      await _googleSignIn.signOut();
      await firebaseAuth.signOut();

      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final googleAuth = await googleSignInAccount.authentication;

        if (googleAuth.accessToken != null || googleAuth.idToken != null) {
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          await firebaseAuth.signInWithCredential(credential);
        }
        final user = UserInfo(
          id: googleSignInAccount.id,
          email: googleSignInAccount.email,
          photoUrl: googleSignInAccount.photoUrl,
          displayName: googleSignInAccount.displayName,
          serverAuthCode: googleSignInAccount.serverAuthCode,
        );
        LocalDataManager.localDataManager?.saveUser(user);

        emit(state.copyWith(user: user));
      }
    } catch (e) {
      emit(state.copyWith(error: 'Login failed! Please try again'));
    }
  }
}
