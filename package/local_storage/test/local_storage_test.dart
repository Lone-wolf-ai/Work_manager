import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_local_storage_tanjim/local_storage.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LocalStorage', () {
    late LocalStorage localStorage;

    setUp(() async {
      await Hive.initFlutter();
      localStorage = LocalStorage();
      await localStorage.init();
    });

    tearDown(() async {
      await localStorage.clearAll();
      await Hive.deleteBoxFromDisk('localStorage');
      Hive.close();
    });

    test('saveData and readData', () async {
      const key = 'test_key';
      const value = 'test_value';

      await localStorage.saveData(key, value);
      final result = localStorage.readData<String>(key);

      expect(result, equals(value));
    });

    test('removeData', () async {
      const key = 'test_key';
      const value = 'test_value';

      await localStorage.saveData(key, value);
      await localStorage.removeData(key);
      final result = localStorage.readData<String>(key);

      expect(result, isNull);
    });

    test('clearAll', () async {
      const key1 = 'test_key1';
      const value1 = 'test_value1';
      const key2 = 'test_key2';
      const value2 = 'test_value2';

      await localStorage.saveData(key1, value1);
      await localStorage.saveData(key2, value2);
      await localStorage.clearAll();
      final result1 = localStorage.readData<String>(key1);
      final result2 = localStorage.readData<String>(key2);

      expect(result1, isNull);
      expect(result2, isNull);
    });
  });
}
