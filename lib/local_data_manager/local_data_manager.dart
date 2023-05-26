import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class LocalDataManager {
  static final String userKey = 'user_key';

  static LocalDataManager? _singleton;
  late SharedPreferences _sharedPreferences;

  LocalDataManager._internal();

  static Future<LocalDataManager> getInstance() async {
    if (_singleton == null) {
      _singleton = LocalDataManager._internal();
      _singleton!._sharedPreferences = await SharedPreferences.getInstance();
    }
    return _singleton!;
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
    if(local == null) return null;
    return UserInfo.fromMap(json.decode(local));
  }
}
