import 'package:check_list_demo/data/data_sources/local/task_local_storage.dart';
import 'package:check_list_demo/data/providers/tast_data_source_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:check_list_demo/shared/data/local/data_sources/hive_service.dart';
import 'package:check_list_demo/domain/entities/task.dart';

import 'task_data_source_provider_test.mocks.dart';

// Generate mocks for Hive box and StorageService
@GenerateMocks([HiveService])
void main() {
  late MockHiveService<Task> mockHiveService;
  late ProviderContainer container;

  setUp(() {
    mockHiveService = MockHiveService<Task>();

    // Override the Hive.box method to return the mock box
    container = ProviderContainer(overrides: [
      taskHiveBox.overrideWithValue(mockHiveService), // Mock HiveService
      taskLocalStorageProvider
          .overrideWithValue(TaskLocalStorage(mockHiveService)),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  group('Task Providers', () {
    test('taskHiveBox provides a HiveService<Task>', () {
      final hiveService = container.read(taskHiveBox);
      expect(hiveService, isA<HiveService<Task>>());
      expect(hiveService, mockHiveService);
    });

    test(
        'taskLocalStorageProvider provides TaskLocalStorage with correct HiveService',
        () {
      final taskLocalStorage = container.read(taskLocalStorageProvider);
      expect(taskLocalStorage, isA<TaskLocalStorage>());
      expect(taskLocalStorage.storageService, mockHiveService);
    });
  });
}
