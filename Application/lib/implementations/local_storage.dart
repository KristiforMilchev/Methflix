import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage implements IlocalStorage {
  SharedPreferences? _prefs;

  LocalStorage() {
    SharedPreferences.getInstance().then(
      (value) => _prefs = value,
    );
  }

  @override
  Future<dynamic> get(String key) async {
    try {
      return _prefs!.get(key);
    } catch (ex) {
      //TODO add logging
      return null;
    }
  }

  @override
  Future<SharedPreferences?> getSharedPreferences() async {
    if (_prefs != null) {
      return _prefs;
    } else {
      return await SharedPreferences.getInstance();
    }
  }

  @override
  Future<bool> remove(String key) async {
    try {
      await _prefs!.remove(key);
      return true;
    } catch (ex) {
      //TODO add loggin
      return false;
    }
  }

  @override
  Future<bool> set(String key, dynamic value) async {
    try {
      var isSet = false;
      if (value is String) {
        await _prefs!.setString(key, value);
        isSet = true;
      }
      if (value is bool) {
        await _prefs!.setBool(key, value);
        isSet = true;
      }

      if (value is int) {
        await _prefs!.setInt(key, value);
        isSet = true;
      }

      if (value is double) {
        await _prefs!.setDouble(key, value);
        isSet = true;
      }

      if (value is List<String>) {
        await _prefs!.setStringList(key, value);
        isSet = true;
      }

      return isSet;
    } catch (ex) {
      //TODO add Logging in case of an exception
      return false;
    }
  }

  @override
  Future<bool> reloadStorage() async {
    try {
      await _prefs!.reload();
      return true;
    } catch (ex) {
      //TODO add custom exception, and logging
      return false;
    }
  }
}
