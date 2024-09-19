import 'package:check_list_demo/presentation/home/providers/state/check_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:check_list_demo/domain/entities/task.dart';
import 'package:check_list_demo/presentation/home/providers/state/check_list_state.dart';

import 'check_list_notifier_test.mocks.dart';


void main() {
  late MockDeleteTaskUseCase mockDeleteTaskUseCase;
  late MockGetAllTasksUseCase mockGetAllTasksUseCase;
  late MockUpdateTaskUseCase mockUpdateTaskUseCase;
  late MockDeleteAllTasksUseCase mockDeleteAllTasksUseCase;
  late CheckListNotifier notifier;

  setUp(() {
    mockDeleteTaskUseCase = MockDeleteTaskUseCase();
    mockGetAllTasksUseCase = MockGetAllTasksUseCase();
    mockUpdateTaskUseCase = MockUpdateTaskUseCase();
    mockDeleteAllTasksUseCase = MockDeleteAllTasksUseCase();

    notifier = CheckListNotifier(
      mockDeleteTaskUseCase,
      mockGetAllTasksUseCase,
      mockUpdateTaskUseCase,
      mockDeleteAllTasksUseCase,
    );
  });

  final testTask1 = Task(
    id: 1,
    title: 'Task 1',
    description: 'Description 1',
    createdDate: DateTime.now(),
    isFinished: false,
  );
  final testTask2 = Task(
    id: 2,
    title: 'Task 2',
    description: 'Description 2',
    createdDate: DateTime.now(),
    isFinished: true,
  );

  final taskList = [testTask1, testTask2];

  test('fetchTask should load tasks and update state', () async {
    // Arrange
    when(mockGetAllTasksUseCase()).thenAnswer((_) async => taskList);

    // Act
    await notifier.fetchTask();

    // Assert
    expect(notifier.state.tasks, taskList);
    verify(mockGetAllTasksUseCase()).called(1);
  });

  test('deleteTask should delete a task and refresh the list', () async {
    // Arrange
    when(mockDeleteTaskUseCase(any)).thenAnswer((_) async => true);
    when(mockGetAllTasksUseCase()).thenAnswer((_) async => taskList);

    // Act
    await notifier.fetchTask();
    await notifier.deleteTask(1);

    // Assert
    verify(mockDeleteTaskUseCase(1)).called(1);
    verify(mockGetAllTasksUseCase()).called(2);
    expect(notifier.state.tasks, taskList);
  });

  test('deleteAllTasks should delete all tasks and refresh the list', () async {
    // Arrange
    when(mockDeleteAllTasksUseCase()).thenAnswer((_) async {});
    when(mockGetAllTasksUseCase()).thenAnswer((_) async => taskList);

    // Act
    await notifier.deleteAllTasks();

    // Assert
    verify(mockDeleteAllTasksUseCase()).called(1);
    verify(mockGetAllTasksUseCase()).called(1);
    expect(notifier.state.tasks, taskList);
  });

  test('toggleOrder should change order and refresh the list', () async {
    // Arrange
    when(mockGetAllTasksUseCase()).thenAnswer((_) async => taskList);

    // Act
    notifier.toggleOrder();

    // Assert
    expect(notifier.state.order, Order.ascending);
    verify(mockGetAllTasksUseCase()).called(1);
  });

  test('setSort Date should change the sort method and refresh the list', () async {
    // Arrange
    when(mockGetAllTasksUseCase()).thenAnswer((_) async => taskList);

    // Act
    notifier.setSort(Sort.date);

    // Assert
    expect(notifier.state.sort, Sort.date);
    verify(mockGetAllTasksUseCase()).called(1);
  });

  test('setSort Priority should change the sort method and refresh the list', () async {
    // Arrange
    when(mockGetAllTasksUseCase()).thenAnswer((_) async => taskList);

    // Act
    notifier.setSort(Sort.priority);

    // Assert
    expect(notifier.state.sort, Sort.priority);
    verify(mockGetAllTasksUseCase()).called(1);
  });

  test('updateTask should update the task and refresh the list', () async {
    // Arrange
    final updatedTask = testTask1.copyWith(isFinished: true);
    when(mockUpdateTaskUseCase(any)).thenAnswer((_) async => updatedTask);
    when(mockGetAllTasksUseCase()).thenAnswer((_) async => taskList);

    // Act
    await notifier.updateTask(true, testTask1);

    // Assert
    verify(mockUpdateTaskUseCase(updatedTask)).called(1);
    verify(mockGetAllTasksUseCase()).called(1);
  });
}
