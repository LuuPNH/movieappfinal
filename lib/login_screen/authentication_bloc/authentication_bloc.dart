import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieappfinal/login_screen/authentication_bloc/authentication_event.dart';
import 'package:movieappfinal/login_screen/authentication_bloc/authentication_state.dart';
import 'package:movieappfinal/repository/user_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository? _userRepository;
  AuthenticationBloc(UserRepository userRepository) : _userRepository = userRepository, super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    print(event);
    if(event is AuthenticatonStarted) {
        yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticatonLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticatonLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState();
    }
  }

  //AuthenticatonLoggedIn
  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
    yield AuthenticationSuccess(await _userRepository!.getUser());
  }

  //AuthenticatonLoggedOut
  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState() async* {
    yield AuthenticationFailure();
    _userRepository!.signOut();
  }

  //AuthenticatonStarted
  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
      final isSignedIn = await _userRepository!.isSignedIn();
      if(isSignedIn) {
        final firebaseUser = await _userRepository!.getUser();
        yield AuthenticationSuccess(firebaseUser);
      } else {
        yield AuthenticationFailure();
      }
  }
}