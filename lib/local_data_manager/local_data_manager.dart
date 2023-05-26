import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/movie.dart';
import '../model/user.dart';

class LocalDataManager {
  static final String userKey = 'user_key';
  static final String favoriteMovies = 'favorite_movies';

  static LocalDataManager? localDataManager;
  late SharedPreferences _sharedPreferences;

  LocalDataManager._internal();

  static Future<LocalDataManager> getInstance() async {
    if (localDataManager == null) {
      localDataManager = LocalDataManager._internal();
      localDataManager!._sharedPreferences =
          await SharedPreferences.getInstance();
    }
    return localDataManager!;
  }

  Future clearAll() async => await _sharedPreferences.clear();

  void saveUser(UserInfo? user) {
    if (user == null) {
      _sharedPreferences.remove(userKey);
    } else {
      final encode = json.encode(user.toMap());
      _sharedPreferences.setString(userKey, encode);
    }
  }

  UserInfo? get user {
    final local = _sharedPreferences.getString(userKey);
    if (local == null) return null;
    return UserInfo.fromMap(json.decode(local));
  }

  Future<void> saveMovie(Movie movie) async {
    List<Movie> moviesLocal = [];
    String? result = _sharedPreferences.getString(favoriteMovies);
    if (result != null) {
      moviesLocal = (json.decode(result) as List<dynamic>)
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .map<Movie>((e) => Movie.fromMap(e))
          .toList();
      final findMovie = moviesLocal.indexWhere((e) => e.id == movie.id);
      if (findMovie == -1) {
        moviesLocal.add(movie);
      }
    } else {
      moviesLocal.add(movie);
    }

    final encode = json.encode(moviesLocal.map((e) => e.toMap()).toList());
    _sharedPreferences.setString(favoriteMovies, encode);
  }

  List<Movie> removeMovie(Movie movie) {
    String? result = _sharedPreferences.getString(favoriteMovies);

    final moviesLocal = (json.decode(result!) as List<dynamic>)
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .map<Movie>((e) => Movie.fromMap(e))
        .toList();

    moviesLocal.removeWhere((e) => e.id == movie.id);

    return moviesLocal;
  }

  List<Movie> get getListFavoriteMovie {
    String? result = _sharedPreferences.getString(favoriteMovies);
    if (result == null || result.isEmpty) return [];

    return (json.decode(result) as List<dynamic>)
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .map<Movie>((e) => Movie.fromMap(e))
        .toList();
  }
}
