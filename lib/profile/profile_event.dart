part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

@immutable
class InitProfileEvent extends ProfileEvent {}

@immutable
class RefreshProfileEvent extends ProfileEvent {}

@immutable
class RemoveMovieProfileEvent extends ProfileEvent {
  final Movie movie;

  RemoveMovieProfileEvent(this.movie);
}
