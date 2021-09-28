import 'package:flutter/cupertino.dart';
import 'package:movieappfinal/model/movie_response.dart';
import 'package:movieappfinal/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesSearchBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();
  MovieResponse? response;

  getMoviesSearch(String? name, int? page) async {
    response = await _repository.getSearchMovies(name, page ?? 1);
    _subject.add(response!);
  }

  Future<MovieResponse> getMovieSearchMore(String name, int page) async {
    MovieResponse responsetmp = await _repository.getSearchMovies(name, page);
    if (responsetmp.movies.isEmpty) {
      print("Can not load more");
      return responsetmp;
    } else if (responsetmp.movies.isNotEmpty) {
      response!.movies.addAll(responsetmp.movies);
      print(response?.movies.length);
      _subject.add(response!);
      return response!;
    }
    return response!;
  }

  // Future<MovieResponse> loadMore(String name, int page) async {
  //   response = await _repository.getSearchMovies(name, page);
  //   if (response!.movies.isNotEmpty) {
  //     final fetchData = await _repository.getSearchMovies(name, page);
  //     response?.movies.addAll(fetchData.movies);
  //     _subject.add(response!);
  //     return response!;
  //   } else {
  //     _subject.add(response!);
  //     return response!;
  //   }
  // }

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

final moviesSearchBloc = MoviesSearchBloc();
