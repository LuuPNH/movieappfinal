import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:movieappfinal/local_data_manager/local_data_manager.dart';

import '../model/movie.dart';
import '../model/user.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    on<InitProfileEvent>((event, emit) {
      final listFavorite =
          LocalDataManager.localDataManager?.getListFavoriteMovie;
      emit(state.copyWith(
        user: LocalDataManager.localDataManager!.user,
        isLoading: false,
        movies: listFavorite,
      ));
    });
    on<RefreshProfileEvent>((event, emit) {
      emit(state.copyWith(isLoading: true));
      final listFavorite =
          LocalDataManager.localDataManager?.getListFavoriteMovie;
      emit(state.copyWith(
        user: LocalDataManager.localDataManager!.user,
        isLoading: false,
        movies: listFavorite,
      ));
    });
    on<RemoveMovieProfileEvent>((event, emit) {
      emit(state.copyWith(isLoading: true));
      final listFavorite =
          LocalDataManager.localDataManager?.removeMovie(event.movie);
      emit(state.copyWith(
        user: LocalDataManager.localDataManager!.user,
        isLoading: false,
        movies: listFavorite,
      ));
    });
  }
}
