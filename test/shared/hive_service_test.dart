import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:check_list_demo/shared/data/local/data_sources/hive_service.dart';
import 'package:mockito/annotations.dart';
import 'hive_service_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late HiveService<String> hiveService;
  late MockBox<String> mockBox;

  setUp(() {
    mockBox = MockBox<String>();
    hiveService = HiveService<String>(mockBox);
  });

  group('HiveService', () {
    const String key = 'testKey';
    const String value = 'testValue';

    test('clear should clear the box', () async {
      when(mockBox.clear()).thenAnswer((_) async => 0);

      await hiveService.clear();

      verify(mockBox.clear()).called(1);
    });

    test('get should return value from the box', () async {
      when(mockBox.get(key)).thenReturn(value);

      final result = await hiveService.get(key);

      expect(result, equals(value));
      verify(mockBox.get(key)).called(1);
    });

    test('getAll should return all values from the box', () async {
      when(mockBox.values).thenReturn([value]);

      final result = await hiveService.getAll();

      expect(result, equals([value]));
      verify(mockBox.values).called(1);
    });

    test('has should return true if the key exists in the box', () async {
      when(mockBox.containsKey(key)).thenReturn(true);

      final result = await hiveService.has(key);

      expect(result, isTrue);
      verify(mockBox.containsKey(key)).called(1);
    });

    test('remove should delete the key from the box', () async {
      when(mockBox.delete(key)).thenAnswer((_) async => Future.value());

      final result = await hiveService.remove(key);

      expect(result, isTrue);
      verify(mockBox.delete(key)).called(1);
    });

    test('set should store value in the box', () async {
      when(mockBox.put(key, value)).thenAnswer((_) async => Future.value());

      final result = await hiveService.set(key, value);

      expect(result, equals(value));
      verify(mockBox.put(key, value)).called(1);
    });

    test('update should update the value in the box', () async {
      when(mockBox.put(key, value)).thenAnswer((_) async => Future.value());

      final result = await hiveService.update(key, value);

      expect(result, equals(value));
      verify(mockBox.put(key, value)).called(1);
    });
  });
}
