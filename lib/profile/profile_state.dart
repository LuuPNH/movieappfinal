part of 'profile_bloc.dart';

@immutable
class ProfileState {
  final dynamic error;
  final bool isLoading;
  final User? user;

  ProfileState({
    this.error,
    this.isLoading = false,
    this.user,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileState &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          isLoading == other.isLoading &&
          user == other.user;

  @override
  int get hashCode => error.hashCode ^ isLoading.hashCode ^ user.hashCode;

  ProfileState copyWith({
    dynamic error,
    bool? isLoading,
    User? user,
  }) =>
      ProfileState(
        error: error ?? null,
        isLoading: isLoading ?? false,
        user: user ?? this.user,
      );
}
