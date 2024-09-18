import 'package:check_list_demo/domain/entities/task.dart';
import 'package:equatable/equatable.dart';

enum Sort {
  priority("Priority"),
  date("Date");

  const Sort(this.name);

  final String name;
}

enum Order { descending, ascending }

enum Filter {
  current(false),
  archive(true);

  const Filter(this.value);

  final bool value;
}

class CheckListState extends Equatable {
  final List<Task> tasks;
  final Sort sort;
  final Order order;
  final Filter filter;
  final List<Sort> sortValues = [Sort.date, Sort.priority];

  CheckListState(
      {required this.tasks,
      required this.sort,
      required this.order,
      required this.filter});

  CheckListState.initial(
      {this.tasks = const [],
      this.sort = Sort.date,
      this.order = Order.descending,
      this.filter = Filter.current});

  int get todoTasksCount => todoTasks.length;

  int get archiveTasksCount => archiveTasks.length;

  int get totalTasksCount => tasks.length;

  List<Task> get todoTasks =>
      tasks.where((task) => task.isFinished == false).toList();

  List<Task> get archiveTasks =>
      tasks.where((task) => task.isFinished == true).toList();

  @override
  List<Object?> get props => [tasks, sort, order, filter];

  CheckListState copyWith({
    List<Task>? tasks,
    Sort? sort,
    Order? order,
    Filter? filter,
  }) {
    return CheckListState(
      tasks: tasks ?? this.tasks,
      sort: sort ?? this.sort,
      order: order ?? this.order,
      filter: filter ?? this.filter,
    );
  }
}
