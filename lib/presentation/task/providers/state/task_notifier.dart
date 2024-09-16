import 'dart:math';

import 'package:check_list_demo/presentation/task/providers/state/task_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/task.dart';
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
  ) : super(TaskState.initial());
  final CreateTaskUseCase _createTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final GetTaskByIdUseCase _getTaskByIdUseCase;

  Future<void> fetchTask(int id) async {
    final task = await _getTaskByIdUseCase(id);
    state = state.copyWith(task: task);
  }

  Future<void> addTask({required String title, String? description}) async {
    final task = Task(
        id: Random().nextInt(1000),
        title: title,
        description: description,
        isFinished: false,
        createdDate: DateTime.now());
    final newTask = await _createTaskUseCase(task);
    state = state.copyWith(task: newTask);
  }

  Future<void> updateTask(Task task) async {
    await _updateTaskUseCase(task);
    final newTask = await _createTaskUseCase(task);
    state = state.copyWith(task: newTask);
  }

  Future<void> deleteTask(int id) async {
    await _deleteTaskUseCase(id);
  }
}
