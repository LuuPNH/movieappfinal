part of 'profile_bloc.dart';

@immutable
class ProfileState {
  final dynamic error;
  final bool isLoading;
  final UserInfo? user;
  final List<Movie>? movies;

  ProfileState({
    this.error,
    this.isLoading = true,
    this.user,
    this.movies,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileState &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          isLoading == other.isLoading &&
          listEquals(movies, other.movies) &&
          user == other.user;

  @override
  int get hashCode => error.hashCode ^ isLoading.hashCode ^ user.hashCode ^ movies.hashCode;

  ProfileState copyWith({
    dynamic error,
    bool? isLoading,
    UserInfo? user,
    List<Movie>? movies,
  }) =>
      ProfileState(
        error: error ?? null,
        isLoading: isLoading ?? false,
        user: user ?? this.user,
        movies: movies ?? this.movies,
      );
}
