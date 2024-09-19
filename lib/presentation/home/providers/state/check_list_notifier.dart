import 'package:check_list_demo/domain/usecases/delete_all_tasks_usecase.dart';
import 'package:check_list_demo/domain/usecases/delete_task_usecase.dart';
import 'package:check_list_demo/domain/usecases/get_all_tasks_usecase.dart';
import 'package:check_list_demo/domain/usecases/update_task_usecase.dart';
import 'package:check_list_demo/presentation/home/providers/state/check_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/task.dart';
import '../../../../domain/providers/task_usecase_providers.dart';

final checkListNotifierProvider =
    StateNotifierProvider.autoDispose<CheckListNotifier, CheckListState>(
        (ref) => CheckListNotifier(
              ref.read(deleteTaskUseCaseProvider),
              ref.read(getAllTasksUseCaseProvider),
              ref.read(updateTaskUseCaseProvider),
              ref.read(deleteAllTasksUseCaseProvider),
            ));

class CheckListNotifier extends StateNotifier<CheckListState> {
  final DeleteTaskUseCase _deleteTaskUseCase;
  final GetAllTasksUseCase _getAllTasksUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteAllTasksUseCase _deleteAllTaskUseCase;

  CheckListNotifier(
    this._deleteTaskUseCase,
    this._getAllTasksUseCase,
    this._updateTaskUseCase,
    this._deleteAllTaskUseCase,
  ) : super(CheckListState.initial());

  Future<void> fetchTask() async {
    final tasks = await _getAllTasksUseCase();
    sortTasks(tasks, sort: state.sort, order: state.order);
    state = state.copyWith(tasks: tasks);
  }

  Future<void> deleteAllTasks() async {
    await _deleteAllTaskUseCase();
    return fetchTask();
  }

  Future<void> deleteTask(int id) async {
    await _deleteTaskUseCase(id);
    fetchTask();
  }

  void toggleOrder() {
    final newOrder =
        state.order == Order.ascending ? Order.descending : Order.ascending;
    state = state.copyWith(order: newOrder);
    fetchTask();
  }

  void setSort(Sort sort) {
    state = state.copyWith(sort: sort);
    fetchTask();
  }

  void setFilter(Filter filter) {
    state = state.copyWith(filter: filter);
    fetchTask();
  }

  void sortTasks(
    List<Task>? tasks, {
    required Sort sort,
    required Order order,
  }) {
    tasks?.sort((a, b) {
      int compareResult;
      switch (sort) {
        case Sort.priority:
          compareResult =
              a.priority?.value.compareTo(b.priority?.value ?? 0) ?? 0;
        case Sort.date:
          compareResult = a.createdDate?.millisecondsSinceEpoch
                  .compareTo(b.createdDate?.millisecondsSinceEpoch ?? 0) ??
              0;
      }
      return order == Order.ascending ? compareResult : -compareResult;
    });
  }

  Future<void> updateTask(bool? value, Task task) async {
    final newTask = task.copyWith(isFinished: value);
    await _updateTaskUseCase(newTask);
    await fetchTask();
  }
}
