import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:check_list_demo/domain/usecases/delete_all_tasks_usecase.dart';

import '../providers/task_domain_provider_test.mocks.dart';

void main() {
  late MockTaskRepository mockTaskRepository;
  late DeleteAllTasksUseCase deleteAllTasksUseCase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    deleteAllTasksUseCase = DeleteAllTasksUseCase(mockTaskRepository);
  });

  test('should call deleteAllTasks method from TaskRepository', () async {
    // Arrange: Set up the expected behavior for the mock repository
    when(mockTaskRepository.deleteAllTasks()).thenAnswer((_) async => Future.value());

    // Act: Invoke the use case
    await deleteAllTasksUseCase();

    // Assert: Verify that the deleteAllTasks method was called
    verify(mockTaskRepository.deleteAllTasks()).called(1);
  });
}
