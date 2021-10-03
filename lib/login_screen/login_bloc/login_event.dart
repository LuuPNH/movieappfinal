class LoginState {
  final bool? isEmailValid;
  final bool? isPasswordVaild;
  final bool? isSummiting;
  final bool? isSuccess;
  final bool? isFailure;

  bool get isFormValid => isEmailValid! && isPasswordVaild!;

  LoginState({required this.isEmailValid,required this.isPasswordVaild,required this.isSummiting,required this.isSuccess,required this.isFailure});

  factory LoginState.initial() {
    return LoginState(
      isEmailValid: true,
      isPasswordVaild: true,
      isSummiting: false,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory LoginState.loading() {
    return LoginState(
      isEmailValid: true,
      isPasswordVaild: true,
      isSummiting: true,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory LoginState.failure() {
    return LoginState(
      isEmailValid: true,
      isPasswordVaild: true,
      isSummiting: false,
      isSuccess: false,
      isFailure: true,
    );
  }
  factory LoginState.success() {
    return LoginState(
      isEmailValid: true,
      isPasswordVaild: true,
      isSummiting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  LoginState update(bool? isEmailValid, bool? isPasswordValid) {
      return copyWith(
          isEmailValid,
          isPasswordVaild,
          false,
          false,
          false);
  }

  LoginState copyWith( bool? isEmailVaild, bool? isPasswordVaild, bool? isSumitting, bool? isSuccess, bool? isFailure
      ){
        return LoginState(
            isEmailValid: isEmailVaild ?? this.isEmailValid,
          isPasswordVaild: isPasswordVaild ?? this.isPasswordVaild,
          isSummiting: isSumitting ?? this.isSummiting,
          isSuccess: isSuccess ?? this.isSuccess,
          isFailure: isFailure ?? this.isFailure);
  }
}