import 'package:equatable/equatable.dart';

import '../../../../domain/entities/task.dart';

enum TaskMode { view, create, edit }

class TaskState extends Equatable {
  final Task? task;
  final TaskMode mode;

  const TaskState({
    this.task,
    required this.mode,
  });

  const TaskState.initial({
    this.task,
    this.mode = TaskMode.create,
  });

  @override
  List<Object?> get props => [task, mode];

  TaskState copyWith({
    Task? task,
    TaskMode? mode,
  }) {
    return TaskState(
      task: task ?? this.task,
      mode: mode ?? this.mode,
    );
  }
}
