import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:check_list_demo/domain/entities/task.dart';
import 'package:check_list_demo/domain/usecases/get_all_tasks_usecase.dart';

import '../providers/task_domain_provider_test.mocks.dart';

void main() {
  late MockTaskRepository mockTaskRepository;
  late GetAllTasksUseCase getAllTasksUseCase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    getAllTasksUseCase = GetAllTasksUseCase(mockTaskRepository);
  });

  final testTasks = [
    Task(id: 1, title: 'Task 1', description: 'Description 1', isFinished: false, createdDate: DateTime.now()),
    Task(id: 2, title: 'Task 2', description: 'Description 2', isFinished: true, createdDate: DateTime.now())
  ];

  test('should call getAllTasks method from TaskRepository and return list of tasks', () async {
    // Arrange: Set up the expected behavior for the mock repository
    when(mockTaskRepository.getAllTasks()).thenAnswer((_) async => testTasks);

    // Act: Invoke the use case
    final result = await getAllTasksUseCase();

    // Assert: Verify that the getAllTasks method was called and returned the correct tasks
    verify(mockTaskRepository.getAllTasks()).called(1);
    expect(result, equals(testTasks));
  });
}
