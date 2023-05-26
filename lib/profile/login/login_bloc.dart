import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' hide UserInfo;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:movieappfinal/model/user.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginGGEvent>(_onAddLoginGG);
  }

  Future<void> _onAddLoginGG(
      LoginGGEvent event, Emitter<LoginState> emit) async {
    final _googleSignIn = GoogleSignIn(
      // clientId:
      //     '341310941631-56djukbf3edjbaf5tuctu81hhcam087e.apps.googleusercontent.com',
    );

    final googleSignInAccount = await _googleSignIn.signIn();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
      emit(state.copyWith(user: user));
    }
    emit(state.copyWith(error: 'Login failed! Please try again'));
  }
}
