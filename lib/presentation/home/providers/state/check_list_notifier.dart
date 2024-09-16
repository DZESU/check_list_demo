import 'package:check_list_demo/domain/usecases/delete_all_tasks_usecase.dart';
import 'package:check_list_demo/domain/usecases/delete_task_usecase.dart';
import 'package:check_list_demo/domain/usecases/get_all_tasks_usecase.dart';
import 'package:check_list_demo/presentation/home/providers/state/check_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/task.dart';

final checkListNotifierProvider =
    StateNotifierProvider.autoDispose<CheckListNotifier, CheckListState>(
        (ref) => CheckListNotifier(
              ref.read(deleteTaskUseCaseProvider),
              ref.read(getAllTasksUseCaseProvider),
              ref.read(deleteAllTasksUseCaseProvider),
            ));

class CheckListNotifier extends StateNotifier<CheckListState> {
  final DeleteTaskUseCase _deleteTaskUseCase;
  final GetAllTasksUseCase _getAllTasksUseCase;
  final DeleteAllTasksUseCase _deleteAllTaskUseCase;

  CheckListNotifier(
    this._deleteTaskUseCase,
    this._getAllTasksUseCase,
    this._deleteAllTaskUseCase,
  ) : super(const CheckListState.initial());

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

  void sortTasks(
    List<Task> tasks, {
    required Sort sort,
    required Order order,
  }) {
    //TODO revise this logic
    tasks.sort((a, b) {
      int compareResult = 0;

      switch (sort) {
        case Sort.priority:
          compareResult =
              (a.priority?.index ?? 0).compareTo(b.priority?.index ?? 0);
          return compareResult;
        // if (compareResult != 0) {
        //   return order == Order.ascending ? compareResult : -compareResult;
        // }
        case Sort.date:
          DateTime? dateA = a.updatedDate ?? a.createdDate;
          DateTime? dateB = b.updatedDate ?? b.createdDate;
          compareResult = dateA?.compareTo(dateB ?? DateTime.now()) ?? 0;
          if (compareResult != 0) {
            return order == Order.ascending ? compareResult : -compareResult;
          }
      }
      return compareResult;
    });
  }
}
