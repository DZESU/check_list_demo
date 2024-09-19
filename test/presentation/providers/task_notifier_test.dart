import 'package:check_list_demo/presentation/task/providers/state/task_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:check_list_demo/domain/entities/task.dart';
import 'package:check_list_demo/domain/entities/priority.dart';
import 'package:check_list_demo/presentation/task/providers/state/task_state.dart';
import 'package:mockito/mockito.dart';

import 'task_notifier_test.mocks.dart';

void main() {
  group('TaskNotifier', () {
    late MockCreateTaskUseCase mockCreateTaskUseCase;
    late MockUpdateTaskUseCase mockUpdateTaskUseCase;
    late MockGetTaskByIdUseCase mockGetTaskByIdUseCase;
    late TaskNotifier taskNotifier;

    setUp(() {
      mockCreateTaskUseCase = MockCreateTaskUseCase();
      mockUpdateTaskUseCase = MockUpdateTaskUseCase();
      mockGetTaskByIdUseCase = MockGetTaskByIdUseCase();
      taskNotifier = TaskNotifier(
        mockCreateTaskUseCase,
        mockUpdateTaskUseCase,
        mockGetTaskByIdUseCase,
      );
    });

    test('initial state is TaskState.initial', () {
      expect(taskNotifier.state, const TaskState.initial());
    });

    test('init with taskId loads the task', () async {
      final task = Task(id: 1, title: 'Test Task');
      when(mockGetTaskByIdUseCase(1)).thenAnswer((_) async => task);

      await taskNotifier.init(TaskMode.edit, 1);

      expect(taskNotifier.state.mode, TaskMode.edit);
      expect(taskNotifier.state.task, task);
      expect(taskNotifier.state.status, TaskStatus.loaded);
    });

    test('init without taskId sets initial task state', () async {
      await taskNotifier.init(TaskMode.create, null);

      expect(taskNotifier.state.mode, TaskMode.create);
      expect(taskNotifier.state.task, isNotNull);
      expect(taskNotifier.state.status, TaskStatus.loaded);
    });

    test('setTitle updates the title', () {
      final task = Task(title: 'Old Title');
      taskNotifier.state = taskNotifier.state.copyWith(task: task);

      taskNotifier.setTitle('New Title');

      expect(taskNotifier.state.task.title, 'New Title');
    });

    test('setDescription updates the description', () {
      final task = Task(description: 'Old Description');
      taskNotifier.state = taskNotifier.state.copyWith(task: task);

      taskNotifier.setDescription('New Description');

      expect(taskNotifier.state.task.description, 'New Description');
    });

    test('saveTask creates a new task', () async {
      final newTask = Task(id: 1, title: 'New Task');
      when(mockCreateTaskUseCase(any)).thenAnswer((_) async => newTask);

      await taskNotifier.saveTask();

      expect(taskNotifier.state.task, newTask);
    });

    test('updateTask updates the task', () async {
      final task = Task(id: 1, title: 'Old Title');
      final updatedTask = Task(id: 1, title: 'New Title');
      taskNotifier.state = taskNotifier.state.copyWith(task: task);
      when(mockUpdateTaskUseCase(any)).thenAnswer((_) async => updatedTask);

      await taskNotifier.updateTask(title: 'New Title');

      expect(taskNotifier.state.task.title, 'New Title');
    });

    test('setPriority updates the priority', () {
      final task = Task(priority: Priority.low);
      taskNotifier.state = taskNotifier.state.copyWith(task: task);

      taskNotifier.setPriority(Priority.high);

      expect(taskNotifier.state.task.priority, Priority.high);
    });

    test('setIsFinished updates the task status and saves if not in create mode', () async {
      final task = Task(isFinished: false);
      taskNotifier.state = taskNotifier.state.copyWith(task: task);
      when(mockUpdateTaskUseCase(any)).thenAnswer((_) async => task.copyWith(isFinished: true));

      await taskNotifier.setIsFinished(true);

      expect(taskNotifier.state.task.isFinished, true);
    });
  });
}
