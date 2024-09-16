import 'package:check_list_demo/domain/entities/task.dart';
import 'package:equatable/equatable.dart';

enum Sort { priority, date }

enum Order { descending, ascending }

class CheckListState extends Equatable {
  final List<Task> tasks;
  final Sort sort;
  final Order order;

  const CheckListState(
      {required this.tasks, required this.sort, required this.order});

  const CheckListState.initial(
      {this.tasks = const [],
      this.sort = Sort.date,
      this.order = Order.ascending});

  int get unfinishedTaskCount => tasks.length;

  @override
  List<Object?> get props => [tasks];

  CheckListState copyWith({
    List<Task>? tasks,
    Sort? sort,
    Order? order,
  }) {
    return CheckListState(
      tasks: tasks ?? this.tasks,
      sort: sort ?? this.sort,
      order: order ?? this.order,
    );
  }
}
