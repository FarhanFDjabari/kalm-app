import 'package:hive/hive.dart';

class DatabaseHelper<T> {
  var box = Hive.box('db');

  void saveList(String key, List<T> list) {
    box.put(key, list);
  }

  Box<T> getCacheBox(String boxName) {
    return Hive.box<T>(boxName);
  }

  Future<bool> saveCacheBox(String key, T data, Box<T> box) async {
    try {
      await box.clear();
      await box.put(key, data);
      return true;
    } catch (e) {
      return false;
    }
  }

  List<T>? getList(String key) {
    List<T> list = box.get('key', defaultValue: <T>[]);
    return list;
  }
}
