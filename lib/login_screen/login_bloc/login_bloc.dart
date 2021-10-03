import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieappfinal/login_screen/login_bloc/login_event.dart';
import 'package:movieappfinal/login_screen/login_bloc/login_state.dart';
import 'package:movieappfinal/repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc(UserRepository userRepository) : _userRepository =  userRepository, super(LoginState.initial());


  @override
  Stream<LoginState> mapEventToState (LoginEvent event) async* {
    if(event is LoginEmailChange) {
      yield* _mapLoginEmailChangeToState(event.email);
    } else if (event is LoginPasswordChanged) {
      yield* _mapLoginChangeChangeToState(event.password);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(event.email,event.password);
    }
  }
  Stream<LoginState> _mapLoginEmailChangeToState(String email) async* {
    yield state.update(true, false);
  }

  Stream<LoginState> _mapLoginChangeChangeToState(String email) async* {
    yield state.update(false, true);
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(String email, String password) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}