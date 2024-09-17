import 'package:check_list_demo/shared/data/local/data_sources/hive_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBox<T> extends Mock implements Box<T> {}

class MockHive extends Mock implements HiveInterface {}

void main() {
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');

  TestWidgetsFlutterBinding.ensureInitialized();

  late HiveService<String> hiveService;
  late MockBox<String> mockBox;
  late MockHive mockHive;

  setUp(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return '/mocked/directory';
      }
      return null;
    });

    mockBox = MockBox<String>();
    mockHive = MockHive();
    hiveService = HiveService<String>();

    await mockHive.initFlutter();
  });


  group('HiveService', () {
    test('getBox should open a box if it is not already open', () async {
      when(() => mockHive.isBoxOpen('testBox')).thenReturn(false);
      when(() => mockHive.openBox<String>('testBox'))
          .thenAnswer((_) async => mockBox);

      final box = await hiveService.getBox('testBox');

      expect(box, mockBox);
      verify(() => mockHive.openBox<String>('testBox')).called(1);
    });

    test('getBox should return the box if it is already open', () async {
      when(() => mockHive.isBoxOpen('testBox')).thenReturn(true);
      when(() => mockHive.box<String>('testBox')).thenReturn(mockBox);

      final box = await hiveService.getBox('testBox');

      expect(box, mockBox);
      verify(() => mockHive.box<String>('testBox')).called(1);
    });

    test('clear should clear the box', () async {
      when(() => mockHive.isBoxOpen('testBox')).thenReturn(true);
      when(() => mockHive.box<String>('testBox')).thenReturn(mockBox);
      when(() => mockBox.clear()).thenAnswer((_) async {
        return 1;
      });

      await hiveService.clear('testBox');

      verify(() => mockBox.clear()).called(1);
    });

    test('get should return the value from the box', () async {
      when(() => mockHive.isBoxOpen('testBox')).thenReturn(true);
      when(() => mockHive.box<String>('testBox')).thenReturn(mockBox);
      when(() => mockBox.get('key')).thenReturn('value');

      final value = await hiveService.get('testBox', 'key');

      expect(value, 'value');
      verify(() => mockBox.get('key')).called(1);
    });

    test('getAll should return all values from the box', () async {
      when(() => mockHive.isBoxOpen('testBox')).thenReturn(true);
      when(() => mockHive.box<String>('testBox')).thenReturn(mockBox);
      when(() => mockBox.values).thenReturn(['value1', 'value2']);

      final values = await hiveService.getAll('testBox');

      expect(values, ['value1', 'value2']);
      verify(() => mockBox.values).called(1);
    });

    test('has should return true if the box contains the key', () async {
      when(() => mockHive.isBoxOpen('testBox')).thenReturn(true);
      when(() => mockHive.box<String>('testBox')).thenReturn(mockBox);
      when(() => mockBox.containsKey('key')).thenReturn(true);

      final containsKey = await hiveService.has('testBox', 'key');

      expect(containsKey, true);
      verify(() => mockBox.containsKey('key')).called(1);
    });

    test('remove should delete the key from the box', () async {
      when(() => mockHive.isBoxOpen('testBox')).thenReturn(true);
      when(() => mockHive.box<String>('testBox')).thenReturn(mockBox);
      when(() => mockBox.delete('key')).thenAnswer((_) async {});

      final result = await hiveService.remove('testBox', 'key');

      expect(result, true);
      verify(() => mockBox.delete('key')).called(1);
    });

    test('set should save the data in the box and return the data', () async {
      when(() => mockHive.isBoxOpen('testBox')).thenReturn(true);
      when(() => mockHive.box<String>('testBox')).thenReturn(mockBox);
      when(() => mockBox.put('key', 'data')).thenAnswer((_) async {});

      final result = await hiveService.set('testBox', 'key', 'data');

      expect(result, 'data');
      verify(() => mockBox.put('key', 'data')).called(1);
    });

    test('update should update the data in the box and return the data',
        () async {
      when(() => mockHive.isBoxOpen('testBox')).thenReturn(true);
      when(() => mockHive.box<String>('testBox')).thenReturn(mockBox);
      when(() => mockBox.put('key', 'updated_data')).thenAnswer((_) async {});

      final result = await hiveService.update('testBox', 'key', 'updated_data');

      expect(result, 'updated_data');
      verify(() => mockBox.put('key', 'updated_data')).called(1);
    });
  });


  tearDown(() {
    tearDownTestHive();
  });
}
