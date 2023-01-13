import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitech_books/app/utils/service_locator.dart';

abstract class LocalCache {
  final SharedPreferences _prefs;

  LocalCache(this._prefs);
  void save<T>(String key, T value);

  T? get<T>(String key);

  bool has(String key);

  void delete(String key);

  static LocalCache get instance => locator.get();

  SharedPreferences get sharedPreferences => _prefs;
}

class LocalCacheImpl extends LocalCache {
  LocalCacheImpl(super.prefs);

  @override
  void delete(String key) => _prefs.remove(key);

  @override
  T? get<T>(String key) {
    if (!_prefs.containsKey(key)) return null;
    return jsonDecode(_prefs.getString(key)!) as T;
  }

  @override
  void save<T>(String key, T value) {
    _prefs.setString(key, jsonEncode(value));
  }

  @override
  bool has(String key) => _prefs.containsKey(key);
}
