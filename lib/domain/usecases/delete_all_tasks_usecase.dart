import 'package:check_list_demo/domain/repositories/task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/task.dart';

final deleteAllTasksUseCaseProvider =
    Provider((ref) => DeleteAllTasksUseCase(ref.read(taskRepositoryProvider)));

class DeleteAllTasksUseCase {
  final TaskRepository _repository;

  DeleteAllTasksUseCase(this._repository);

  Future<bool> call() => _repository.deleteAllTasks();
}
