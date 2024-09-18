import 'package:check_list_demo/domain/entities/priority.dart';
import 'package:check_list_demo/domain/usecases/update_task_usecase.dart';
import 'package:check_list_demo/presentation/home/providers/state/check_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:check_list_demo/domain/usecases/delete_all_tasks_usecase.dart';
import 'package:check_list_demo/domain/usecases/delete_task_usecase.dart';
import 'package:check_list_demo/domain/usecases/get_all_tasks_usecase.dart';
import 'package:check_list_demo/presentation/home/providers/state/check_list_state.dart';
import 'package:check_list_demo/domain/entities/task.dart';

import 'check_list_notifier_test.mocks.dart';

@GenerateMocks([DeleteTaskUseCase, GetAllTasksUseCase, UpdateTaskUseCase,DeleteAllTasksUseCase])
void main() {
  late MockDeleteTaskUseCase mockDeleteTaskUseCase;
  late MockGetAllTasksUseCase mockGetAllTasksUseCase;
  late MockDeleteAllTasksUseCase mockDeleteAllTasksUseCase;
  late MockUpdateTaskUseCase mockUpdateTaskUseCase;
  late CheckListNotifier checkListNotifier;

  setUp(() {
    mockDeleteTaskUseCase = MockDeleteTaskUseCase();
    mockGetAllTasksUseCase = MockGetAllTasksUseCase();
    mockDeleteAllTasksUseCase = MockDeleteAllTasksUseCase();
    mockUpdateTaskUseCase = MockUpdateTaskUseCase();
    checkListNotifier = CheckListNotifier(
      mockDeleteTaskUseCase,
      mockGetAllTasksUseCase,
      mockUpdateTaskUseCase,
      mockDeleteAllTasksUseCase,
    );
  });

  group('CheckListNotifier', () {
    final List<Task> taskList = [
      Task(id: 1, title: 'Task 1', description: 'Test Task 1'),
      Task(id: 2, title: 'Task 2', description: 'Test Task 2'),
    ];

    test('fetchTask should load tasks and update state', () async {
      when(mockGetAllTasksUseCase()).thenAnswer((_) async => taskList);

      await checkListNotifier.fetchTask();

      expect(checkListNotifier.state.tasks, equals(taskList));
      verify(mockGetAllTasksUseCase()).called(1);
    });

    test('deleteTask should remove a task and fetch tasks again', () async {
      when(mockDeleteTaskUseCase(any)).thenAnswer((_) async => Future.value(true));
      when(mockGetAllTasksUseCase()).thenAnswer((_) async => taskList);

      await checkListNotifier.deleteTask(1);

      verify(mockDeleteTaskUseCase(1)).called(1);
      verify(mockGetAllTasksUseCase()).called(1);
    });

    test('deleteAllTasks should clear tasks and fetch tasks again', () async {
      when(mockDeleteAllTasksUseCase()).thenAnswer((_) async => Future.value());
      when(mockGetAllTasksUseCase()).thenAnswer((_) async => []);

      await checkListNotifier.deleteAllTasks();

      expect(checkListNotifier.state.tasks, equals([]));
      verify(mockDeleteAllTasksUseCase()).called(1);
      verify(mockGetAllTasksUseCase()).called(1);
    });

    test('toggleOrder should update state and fetch tasks in new order', () async {
      checkListNotifier.state = checkListNotifier.state.copyWith(order: Order.ascending);
      when(mockGetAllTasksUseCase()).thenAnswer((_) async => taskList);

      checkListNotifier.toggleOrder();

      expect(checkListNotifier.state.order, equals(Order.descending));
      verify(mockGetAllTasksUseCase()).called(1);
    });

    test('setSort should update state and fetch tasks with new sort criteria', () async {
      when(mockGetAllTasksUseCase()).thenAnswer((_) async => taskList);

      checkListNotifier.setSort(Sort.date);

      expect(checkListNotifier.state.sort, equals(Sort.date));
      verify(mockGetAllTasksUseCase()).called(1);
    });

    test('sortTasks should sort tasks by priority', () {
      final List<Task> unsortedTasks = [
        Task(id: 1, title: 'Task 1', priority: Priority.low),
        Task(id: 2, title: 'Task 2', priority: Priority.high),
      ];

      checkListNotifier.sortTasks(unsortedTasks, sort: Sort.priority, order: Order.descending);

      expect(unsortedTasks[0].id, equals(2)); // Task with higher priority should be first
    });

    test('sortTasks should sort tasks by date', () {
      final DateTime now = DateTime.now();
      final List<Task> unsortedTasks = [
        Task(id: 1, title: 'Task 1', createdDate: now.subtract(Duration(days: 1))),
        Task(id: 2, title: 'Task 2', createdDate: now),
      ];

      checkListNotifier.sortTasks(unsortedTasks, sort: Sort.date, order: Order.ascending);

      expect(unsortedTasks[0].id, equals(1)); // Older task should be first in ascending order
    });
  });
}
