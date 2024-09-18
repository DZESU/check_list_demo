import 'package:equatable/equatable.dart';

import '../../../../domain/entities/task.dart';

enum TaskMode { view, create, edit }

enum TaskStatus { initial, loading, loaded }

class TaskState extends Equatable {
  final Task task;
  final TaskMode mode;
  final TaskStatus status;

  const TaskState({
    required this.task,
    required this.mode,
    required this.status,
  });

  const TaskState.initial({
    this.task = const Task(),
    this.mode = TaskMode.view,
    this.status = TaskStatus.initial,
  });

  @override
  List<Object?> get props => [task, mode, status];

  TaskState copyWith({
    Task? task,
    TaskMode? mode,
    TaskStatus? status,
  }) {
    return TaskState(
      task: task ?? this.task,
      mode: mode ?? this.mode,
      status: status ?? this.status,
    );
  }
}
