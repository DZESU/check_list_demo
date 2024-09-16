import 'package:check_list_demo/domain/repositories/task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/task.dart';

final updateTaskUseCaseProvider =
Provider((ref) => UpdateTaskUseCase(ref.read(taskRepositoryProvider)));


class UpdateTaskUseCase{
  final TaskRepository _repository;

  UpdateTaskUseCase(this._repository);

  Future<Task> call(Task task)=>_repository.updateTask(task);
}