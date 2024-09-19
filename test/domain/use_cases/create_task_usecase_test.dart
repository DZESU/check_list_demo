import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:check_list_demo/domain/entities/task.dart';
import 'package:check_list_demo/domain/usecases/create_task_usecase.dart';

import '../providers/task_usecase_provider_test.mocks.dart';

void main() {
  late MockTaskRepository mockTaskRepository;
  late CreateTaskUseCase createTaskUseCase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    createTaskUseCase = CreateTaskUseCase(mockTaskRepository);
  });

  final testTask = Task(
    id: 1,
    title: "Test Task",
    description: "This is a test task",
    isFinished: false,
    createdDate: DateTime.now(),
  );

  test('should call createTask method from TaskRepository and return Task',
      () async {
    // Arrange: Set up the expected behavior for the mock repository
    when(mockTaskRepository.createTask(testTask))
        .thenAnswer((_) async => testTask);

    // Act: Invoke the use case
    final result = await createTaskUseCase(testTask);

    // Assert: Verify that the createTask method was called with the correct Task
    verify(mockTaskRepository.createTask(testTask)).called(1);
    expect(result, equals(testTask));
  });
}
