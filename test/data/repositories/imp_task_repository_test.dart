import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:check_list_demo/data/data_sources/local/task_local_storage.dart';
import 'package:check_list_demo/data/repositories/imp_task_repository.dart';
import 'package:check_list_demo/domain/entities/task.dart';

import 'imp_task_repository_test.mocks.dart';

@GenerateMocks([TaskLocalStorage])
void main() {
  late MockTaskLocalStorage mockTaskLocalStorage;
  late ImpTaskRepository impTaskRepository;

  setUp(() {
    mockTaskLocalStorage = MockTaskLocalStorage();
    impTaskRepository = ImpTaskRepository(mockTaskLocalStorage);
  });

  group('ImpTaskRepository', () {
    const int taskId = 1;
    final Task task = Task(id: taskId, title: 'Test Task', description: 'Description');

    test('getAllTasks should retrieve all tasks from TaskLocalStorage', () async {
      when(mockTaskLocalStorage.getAllTasks()).thenAnswer((_) async => [task]);

      final result = await impTaskRepository.getAllTasks();

      expect(result, equals([task]));
      verify(mockTaskLocalStorage.getAllTasks()).called(1);
    });

    test('getTaskById should retrieve the correct task from TaskLocalStorage', () async {
      when(mockTaskLocalStorage.getTaskById(taskId)).thenAnswer((_) async => task);

      final result = await impTaskRepository.getTaskById(taskId);

      expect(result, equals(task));
      verify(mockTaskLocalStorage.getTaskById(taskId)).called(1);
    });

    test('createTask should create task using TaskLocalStorage', () async {
      when(mockTaskLocalStorage.createTask(task)).thenAnswer((_) async => task);

      final result = await impTaskRepository.createTask(task);

      expect(result, equals(task));
      verify(mockTaskLocalStorage.createTask(task)).called(1);
    });

    test('updateTask should update task using TaskLocalStorage', () async {
      when(mockTaskLocalStorage.updateTask(task)).thenAnswer((_) async => task);

      final result = await impTaskRepository.updateTask(task);

      expect(result, equals(task));
      verify(mockTaskLocalStorage.updateTask(task)).called(1);
    });

    test('deleteTask should remove task using TaskLocalStorage', () async {
      when(mockTaskLocalStorage.deleteTask(taskId)).thenAnswer((_) async => true);

      final result = await impTaskRepository.deleteTask(taskId);

      expect(result, isTrue);
      verify(mockTaskLocalStorage.deleteTask(taskId)).called(1);
    });

    test('deleteAllTasks should clear all tasks using TaskLocalStorage', () async {
      when(mockTaskLocalStorage.deleteAllTasks()).thenAnswer((_) async => Future.value());

      await impTaskRepository.deleteAllTasks();

      verify(mockTaskLocalStorage.deleteAllTasks()).called(1);
    });
  });
}
