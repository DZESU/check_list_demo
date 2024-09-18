import 'dart:math';
import 'package:check_list_demo/presentation/task/providers/state/task_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:check_list_demo/presentation/task/providers/state/task_state.dart';
import 'package:check_list_demo/domain/usecases/create_task_usecase.dart';
import 'package:check_list_demo/domain/usecases/delete_task_usecase.dart';
import 'package:check_list_demo/domain/usecases/get_task_by_id_usecase.dart';
import 'package:check_list_demo/domain/usecases/update_task_usecase.dart';
import 'package:check_list_demo/domain/entities/task.dart';

import 'task_notifier_test.mocks.dart';

@GenerateMocks([
  CreateTaskUseCase,
  UpdateTaskUseCase,
  DeleteTaskUseCase,
  GetTaskByIdUseCase
])
void main() {
  late MockCreateTaskUseCase mockCreateTaskUseCase;
  late MockUpdateTaskUseCase mockUpdateTaskUseCase;
  late MockDeleteTaskUseCase mockDeleteTaskUseCase;
  late MockGetTaskByIdUseCase mockGetTaskByIdUseCase;
  late TaskNotifier taskNotifier;
  final DateTime createdDate = DateTime(2000, 1, 1);

  setUp(() {
    mockCreateTaskUseCase = MockCreateTaskUseCase();
    mockUpdateTaskUseCase = MockUpdateTaskUseCase();
    mockDeleteTaskUseCase = MockDeleteTaskUseCase();
    mockGetTaskByIdUseCase = MockGetTaskByIdUseCase();
    taskNotifier = TaskNotifier(
      mockCreateTaskUseCase,
      mockUpdateTaskUseCase,
      mockDeleteTaskUseCase,
      mockGetTaskByIdUseCase,
    );
  });

  group('TaskNotifier', () {
    final Task task = Task(
      id: 1,
      title: 'Test Task',
      description: 'Task description',
      isFinished: false,
      createdDate: createdDate,
    );

    test('fetchTask should load task by id and update state', () async {
      when(mockGetTaskByIdUseCase(1)).thenAnswer((_) async => task);

      final stateChanges = <TaskState>[];
      taskNotifier.addListener((state) {
        stateChanges.add(state);
      });

      await taskNotifier.fetchTask(1);

      // Check the recorded states
      expect(stateChanges.length, 2); // Initial state and updated state
      expect(stateChanges[0], TaskState.initial());
      expect(
          stateChanges[1],
          TaskState(
              task: task, mode: TaskMode.view, status: TaskStatus.loaded));

      verify(mockGetTaskByIdUseCase(1)).called(1);
    });

    test('addTask should create a new task and update state', () async {
      final newTask =
          task.copyWith(id: Random().nextInt(1000), title: 'New Task');
      when(mockCreateTaskUseCase(any)).thenAnswer((_) async => newTask);

      final stateChanges = <TaskState>[];
      taskNotifier.addListener((state) {
        stateChanges.add(state);
      });

      await taskNotifier.addTask(
          title: 'New Task', description: 'New Task Description');

      // Check the recorded states
      expect(stateChanges.length, 2); // Initial state and updated state
      expect(stateChanges[0], TaskState.initial());
      expect(stateChanges[1], TaskState(task: newTask, mode: TaskMode.view, status: TaskStatus.initial));

      verify(mockCreateTaskUseCase(any)).called(1);
    });

    test('updateTask should update the task and reflect changes in state',
        () async {
      final title = "Update Title";
      final description = "Update Description";
      final updatedTask = task.copyWith(title: title, description: description);
      when(mockUpdateTaskUseCase(any)).thenAnswer((_) async => updatedTask);

      final stateChanges = <TaskState>[];
      taskNotifier.addListener((state) {
        stateChanges.add(state);
      });

      await taskNotifier.updateTask(title: title, description: description);

      // Check the recorded states
      expect(stateChanges.length, 2); // Initial state and updated state
      expect(stateChanges[0], TaskState.initial());
      expect(
          stateChanges[1], TaskState(task: updatedTask, mode: TaskMode.view, status: TaskStatus.initial));

      verify(mockUpdateTaskUseCase(any)).called(1);
    });

    test('deleteTask should remove task and not affect state', () async {
      when(mockDeleteTaskUseCase(1)).thenAnswer((_) async => true);

      final stateChanges = <TaskState>[];
      taskNotifier.addListener((state) {
        stateChanges.add(state);
      });

      await taskNotifier.deleteTask(1);

      // Check the recorded states
      expect(
          stateChanges.length, 1); // Only the initial state should be recorded
      expect(stateChanges[0], TaskState.initial());

      verify(mockDeleteTaskUseCase(1)).called(1);
    });
  });
}
