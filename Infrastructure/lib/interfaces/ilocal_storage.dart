import 'package:shared_preferences/shared_preferences.dart';

abstract class IlocalStorage {
  Future<SharedPreferences?> getSharedPreferences();
  Future<bool> set(String key, dynamic value);
  Future<dynamic> get(String key);
  Future<bool> remove(String key);
  Future<bool> reloadStorage();
}
