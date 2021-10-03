import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthenticatonStarted extends AuthenticationEvent {}

class AuthenticatonLoggedIn extends AuthenticationEvent {}

class AuthenticatonLoggedOut extends AuthenticationEvent {}