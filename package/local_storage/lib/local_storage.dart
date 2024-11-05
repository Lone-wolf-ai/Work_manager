import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  LocalStorage._internal();

  late Box _storage;

  // Initialize Hive
  Future<void> init() async {
    await Hive.initFlutter();
    _storage = await Hive.openBox('localStorage');
  }

  // Generic method to save data
  Future<void> saveData<T>(String key, T value) async {
    await _storage.put(key, value);
  }

  // Generic method to read data
  T? readData<T>(String key) {
    return _storage.get(key);
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.delete(key);
  }

  // Clear all data in storage
  Future<void> clearAll() async {
    await _storage.clear();
  }
}
