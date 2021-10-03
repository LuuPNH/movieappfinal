import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState();

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final FirebaseAuth firebaseUser;

  AuthenticationSuccess(this.firebaseUser);
  @override
  // TODO: implement props
  List<Object?> get props => [firebaseUser];
}

class AuthenticationFailure extends AuthenticationState {}