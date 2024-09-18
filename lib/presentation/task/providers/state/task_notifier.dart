import 'dart:math';

import 'package:check_list_demo/domain/entities/priority.dart';
import 'package:check_list_demo/presentation/task/providers/state/task_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/task.dart';
import '../../../../domain/providers/task_usecase_providers.dart';
import '../../../../domain/usecases/create_task_usecase.dart';
import '../../../../domain/usecases/delete_task_usecase.dart';
import '../../../../domain/usecases/get_task_by_id_usecase.dart';
import '../../../../domain/usecases/update_task_usecase.dart';

final taskNotifierProvider =
    StateNotifierProvider.autoDispose<TaskNotifier, TaskState>(
        (ref) => TaskNotifier(
              ref.read(createTaskUseCaseProvider),
              ref.read(updateTaskUseCaseProvider),
              ref.read(deleteTaskUseCaseProvider),
              ref.read(getTaskByIdUseCaseProvider),
            ));

class TaskNotifier extends StateNotifier<TaskState> {
  TaskNotifier(
    this._createTaskUseCase,
    this._updateTaskUseCase,
    this._deleteTaskUseCase,
    this._getTaskByIdUseCase,
  ) : super(const TaskState.initial());
  final CreateTaskUseCase _createTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final GetTaskByIdUseCase _getTaskByIdUseCase;

  void init(TaskMode taskMode, int? taskId) async {
    if (taskId != null) {
      state = state.copyWith(mode: taskMode, status: TaskStatus.loading);
      fetchTask(taskId);
    } else {
      state = state.copyWith(
          mode: taskMode, status: TaskStatus.loaded, task: Task());
    }
  }

  Future<void> fetchTask(int id) async {
    final task = await _getTaskByIdUseCase(id);
    state = state.copyWith(task: task, status: TaskStatus.loaded);
  }

  void setTitle(String value) {
    state = state.copyWith(task: state.task.copyWith(title: value));
  }

  void setDescription(String value) {
    state = state.copyWith(task: state.task.copyWith(description: value));
  }

  Future<void> addTask({required String title, String? description}) async {
    final task = Task(
        id: Random().nextInt(1000),
        title: title,
        description: description,
        isFinished: false,
        priority: state.task.priority,
        createdDate: DateTime.now());
    final newTask = await _createTaskUseCase(task);
    state = state.copyWith(task: newTask);
  }

  Future<void> saveTask() async {
    final task = state.task.copyWith(
        id: Random().nextInt(1000),
        isFinished: state.task.isFinished ?? false,
        createdDate: DateTime.now());
    final newTask = await _createTaskUseCase(task);
    state = state.copyWith(task: newTask);
  }

  Future<void> updateTask({required String title, String? description}) async {
    final task = state.task.copyWith(title: title, description: description);
    _updateTask(task);
  }

  Future<void> _updateTask(Task task) async {
    final newTask = await _updateTaskUseCase(task);
    state = state.copyWith(task: newTask);
  }

  void setPriority(Priority value) {
    final task = state.task.copyWith(priority: value);
    state = state.copyWith(task: task);
  }

  Future<void> setIsFinished(bool value) async {
    final task = state.task.copyWith(isFinished: value);
    state = state.copyWith(task: task);
    if (state.mode != TaskMode.create) {
      return _updateTask(task);
    }
  }

  Future<void> deleteTask(int id) async {
    await _deleteTaskUseCase(id);
  }
}
