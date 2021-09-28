import 'package:flutter/cupertino.dart';
import 'package:movieappfinal/model/movie_response.dart';
import 'package:movieappfinal/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class SimilarMovieBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getSmililarMovies(int id) async {
    MovieResponse response = await _repository.getSimilarMovies(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = _subject.value;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final similarMoviesBloc = SimilarMovieBloc();
