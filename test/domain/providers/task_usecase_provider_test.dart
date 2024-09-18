import 'package:check_list_demo/domain/providers/task_usecase_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:check_list_demo/domain/repositories/task_repository.dart';
import 'package:check_list_demo/domain/usecases/create_task_usecase.dart';
import 'package:check_list_demo/domain/usecases/delete_all_tasks_usecase.dart';
import 'package:check_list_demo/domain/usecases/delete_task_usecase.dart';
import 'package:check_list_demo/domain/usecases/get_all_tasks_usecase.dart';
import 'package:check_list_demo/domain/usecases/get_task_by_id_usecase.dart';
import 'package:check_list_demo/domain/usecases/update_task_usecase.dart';

import '../../provider_util.dart';
import 'task_domain_provider_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late MockTaskRepository mockTaskRepository;
  late ProviderContainer container;

  setUp(() {
    mockTaskRepository = MockTaskRepository();

    container = createContainer(overrides: [
      taskRepositoryProvider.overrideWithValue(mockTaskRepository),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  group('Task UseCase Providers', () {
    test('taskRepositoryProvider provides an ImpTaskRepository instance', () {
      final repository = container.read(taskRepositoryProvider);
      expect(repository, isA<TaskRepository>());
      expect(repository, mockTaskRepository);
    });

    test('createTaskUseCaseProvider provides CreateTaskUseCase', () {
      final createTaskUseCase = container.read(createTaskUseCaseProvider);
      expect(createTaskUseCase, isA<CreateTaskUseCase>());
    });

    test('deleteAllTasksUseCaseProvider provides DeleteAllTasksUseCase', () {
      final deleteAllTasksUseCase =
          container.read(deleteAllTasksUseCaseProvider);
      expect(deleteAllTasksUseCase, isA<DeleteAllTasksUseCase>());
    });

    test('deleteTaskUseCaseProvider provides DeleteTaskUseCase', () {
      final deleteTaskUseCase = container.read(deleteTaskUseCaseProvider);
      expect(deleteTaskUseCase, isA<DeleteTaskUseCase>());
    });

    test('getAllTasksUseCaseProvider provides GetAllTasksUseCase', () {
      final getAllTasksUseCase = container.read(getAllTasksUseCaseProvider);
      expect(getAllTasksUseCase, isA<GetAllTasksUseCase>());
    });

    test('getTaskByIdUseCaseProvider provides GetTaskByIdUseCase', () {
      final getTaskByIdUseCase = container.read(getTaskByIdUseCaseProvider);
      expect(getTaskByIdUseCase, isA<GetTaskByIdUseCase>());
    });

    test('updateTaskUseCaseProvider provides UpdateTaskUseCase', () {
      final updateTaskUseCase = container.read(updateTaskUseCaseProvider);
      expect(updateTaskUseCase, isA<UpdateTaskUseCase>());
    });
  });
}
