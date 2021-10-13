import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginEmailChange extends LoginEvent {
  final String email;

  LoginEmailChange(this.email);

  @override
  // TODO: implement props
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  LoginPasswordChanged(this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [password];
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed(this.email, this.password);


  @override
  // TODO: implement props
  List<Object?> get props => [email,password];
}