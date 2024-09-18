// import 'package:check_list_demo/data/data_sources/local/task_local_storage.dart';
// import 'package:check_list_demo/domain/entities/task.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:check_list_demo/shared/data/local/data_sources/storage_service.dart';
//
// import 'task_local_storage_test.mocks.dart';
//
// @GenerateMocks([StorageService])
// void main() {
//   late MockStorageService<Task> mockStorageService;
//   late TaskLocalStorage taskLocalStorage;
//
//   setUp(() {
//     mockStorageService = MockStorageService<Task>();
//     taskLocalStorage = TaskLocalStorage(mockStorageService);
//   });
//
//
//   group('TaskLocalStorage', () {
//     const int taskId = 1;
//     final Task task = Task(id: taskId, title: 'Test Task', description: 'Description');
//
//     test('createTask should store task using storageService.set', () async {
//       when(mockStorageService.set(task.id, task))
//           .thenAnswer((_) async => task);
//
//       final result = await taskLocalStorage.createTask(task);
//
//       expect(result, equals(task));
//       verify(mockStorageService.set(task.id, task)).called(1);
//     });
//
//     test('deleteTask should remove task using storageService.remove', () async {
//       when(mockStorageService.remove(taskId))
//           .thenAnswer((_) async => true);
//
//       final result = await taskLocalStorage.deleteTask(taskId);
//
//       expect(result, isTrue);
//       verify(mockStorageService.remove(taskId)).called(1);
//     });
//
//     test('deleteAllTasks should clear all tasks using storageService.clear', () async {
//       when(mockStorageService.clear()).thenAnswer((_) async => Future.value());
//
//       await taskLocalStorage.deleteAllTasks();
//
//       verify(mockStorageService.clear()).called(1);
//     });
//
//     test('updateTask should update task using storageService.update', () async {
//       when(mockStorageService.update(task.id, task))
//           .thenAnswer((_) async => task);
//
//       final result = await taskLocalStorage.updateTask(task);
//
//       expect(result, equals(task));
//       verify(mockStorageService.update(task.id, task)).called(1);
//     });
//
//     test('getTaskById should retrieve task using storageService.get', () async {
//       when(mockStorageService.get(taskId))
//           .thenAnswer((_) async => task);
//
//       final result = await taskLocalStorage.getTaskById(taskId);
//
//       expect(result, equals(task));
//       verify(mockStorageService.get(taskId)).called(1);
//     });
//
//     test('getAllTask should retrieve all tasks using storageService.getAll', () async {
//       when(mockStorageService.getAll()).thenAnswer((_) async => [task]);
//
//       final result = await taskLocalStorage.getAllTasks();
//
//       expect(result, equals([task]));
//       verify(mockStorageService.getAll()).called(1);
//     });
//   });
// }


import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:check_list_demo/shared/data/local/data_sources/storage_service.dart';
import 'package:check_list_demo/domain/entities/task.dart';
import 'package:check_list_demo/data/data_sources/local/task_local_storage.dart';

import 'task_local_storage_test.mocks.dart';

@GenerateMocks([StorageService,Box])
void main() {
  late MockStorageService<Task> mockStorageService;
  late TaskLocalStorage taskLocalStorage;

  setUp(() {
    mockStorageService = MockStorageService<Task>();
    taskLocalStorage = TaskLocalStorage(mockStorageService);

  });


  group('TaskLocalStorage methods', () {
    final task = Task(
      id: 1,
      title: 'Test Task',
      description: 'Task description',
      isFinished: false,
      createdDate: DateTime.now(),
    );

    test('createTask should call storageService.set', () async {
      when(mockStorageService.set(any, any)).thenAnswer((_) async => task);

      final result = await taskLocalStorage.createTask(task);

      expect(result, task);
      verify(mockStorageService.set(task.id, task)).called(1);
    });

    test('deleteTask should call storageService.remove', () async {
      when(mockStorageService.remove(any)).thenAnswer((_) async => true);

      final result = await taskLocalStorage.deleteTask(task.id!);

      expect(result, true);
      verify(mockStorageService.remove(task.id)).called(1);
    });

    test('deleteAllTasks should call storageService.clear', () async {
      when(mockStorageService.clear()).thenAnswer((_) async => Future.value());

      await taskLocalStorage.deleteAllTasks();

      verify(mockStorageService.clear()).called(1);
    });

    test('updateTask should call storageService.update', () async {
      when(mockStorageService.update(any, any)).thenAnswer((_) async => task);

      final result = await taskLocalStorage.updateTask(task);

      expect(result, task);
      verify(mockStorageService.update(task.id, task)).called(1);
    });

    test('getTaskById should call storageService.get', () async {
      when(mockStorageService.get(any)).thenAnswer((_) async => task);

      final result = await taskLocalStorage.getTaskById(task.id!);

      expect(result, task);
      verify(mockStorageService.get(task.id)).called(1);
    });

    test('getAllTasks should call storageService.getAll', () async {
      final taskList = [task];
      when(mockStorageService.getAll()).thenAnswer((_) async => taskList);

      final result = await taskLocalStorage.getAllTasks();

      expect(result, taskList);
      verify(mockStorageService.getAll()).called(1);
    });
  });

}

