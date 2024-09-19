import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:check_list_demo/domain/entities/task.dart';
import 'package:check_list_demo/domain/usecases/get_task_by_id_usecase.dart';

import '../providers/task_domain_provider_test.mocks.dart';


void main() {
  late MockTaskRepository mockTaskRepository;
  late GetTaskByIdUseCase getTaskByIdUseCase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    getTaskByIdUseCase = GetTaskByIdUseCase(mockTaskRepository);
  });

  const testTaskId = 1;
  final testTask = Task(
    id: testTaskId,
    title: 'Test Task',
    description: 'Test Description',
    isFinished: false,
    createdDate: DateTime.now(),
  );

  test('should call getTaskById method from TaskRepository and return a Task', () async {
    // Arrange: Set up the expected behavior for the mock repository
    when(mockTaskRepository.getTaskById(testTaskId)).thenAnswer((_) async => testTask);

    // Act: Invoke the use case
    final result = await getTaskByIdUseCase(testTaskId);

    // Assert: Verify that the getTaskById method was called with the correct id
    verify(mockTaskRepository.getTaskById(testTaskId)).called(1);
    expect(result, equals(testTask));
  });

  test('should return null if task with given id is not found', () async {
    // Arrange: Set up the expected behavior for the mock repository when task is not found
    when(mockTaskRepository.getTaskById(testTaskId)).thenAnswer((_) async => null);

    // Act: Invoke the use case
    final result = await getTaskByIdUseCase(testTaskId);

    // Assert: Verify that the getTaskById method was called with the correct id and returned null
    verify(mockTaskRepository.getTaskById(testTaskId)).called(1);
    expect(result, isNull);
  });
}
