import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:check_list_demo/domain/entities/task.dart';
import 'package:check_list_demo/domain/usecases/update_task_usecase.dart';

import '../providers/task_domain_provider_test.mocks.dart';


void main() {
  late MockTaskRepository mockTaskRepository;
  late UpdateTaskUseCase updateTaskUseCase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    updateTaskUseCase = UpdateTaskUseCase(mockTaskRepository);
  });

  final testTask = Task(
    id: 1,
    title: "Updated Task",
    description: "This is the updated task",
    isFinished: true,
    createdDate: DateTime.now(),
  );

  test('should call updateTask method from TaskRepository and return updated Task', () async {
    // Arrange: Set up the expected behavior for the mock repository
    when(mockTaskRepository.updateTask(testTask))
        .thenAnswer((_) async => testTask);

    // Act: Invoke the use case
    final result = await updateTaskUseCase(testTask);

    // Assert: Verify that the updateTask method was called with the correct Task
    verify(mockTaskRepository.updateTask(testTask)).called(1);
    expect(result, equals(testTask));
  });
}
