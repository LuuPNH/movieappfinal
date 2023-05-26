part of 'login_bloc.dart';

@immutable
class LoginState {
  final dynamic error;
  final bool isLoading;
  final UserInfo? user;

  LoginState({
    this.error,
    this.isLoading = true,
    this.user,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginState &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          isLoading == other.isLoading &&
          user == other.user;

  @override
  int get hashCode => error.hashCode ^ isLoading.hashCode ^ user.hashCode;

  LoginState copyWith({
    dynamic error,
    bool? isLoading,
    UserInfo? user,
  }) =>
      LoginState(
        error: error ?? null,
        isLoading: isLoading ?? false,
        user: user ?? this.user,
      );
}
