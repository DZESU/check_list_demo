import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:check_list_demo/domain/usecases/delete_task_usecase.dart';

import '../providers/task_domain_provider_test.mocks.dart';

void main() {
  late MockTaskRepository mockTaskRepository;
  late DeleteTaskUseCase deleteTaskUseCase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    deleteTaskUseCase = DeleteTaskUseCase(mockTaskRepository);
  });

  const testTaskId = 1;

  test('should call deleteTask method from TaskRepository and return true', () async {
    // Arrange: Set up the expected behavior for the mock repository
    when(mockTaskRepository.deleteTask(testTaskId))
        .thenAnswer((_) async => true);

    // Act: Invoke the use case
    final result = await deleteTaskUseCase(testTaskId);

    // Assert: Verify that the deleteTask method was called with the correct id
    verify(mockTaskRepository.deleteTask(testTaskId)).called(1);
    expect(result, equals(true));
  });
}
