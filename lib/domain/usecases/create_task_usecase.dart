import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/task.dart';
import '../repositories/task_repository.dart';

final createTaskUseCaseProvider =
    Provider((ref) => CreateTaskUseCase(ref.read(taskRepositoryProvider)));

class CreateTaskUseCase {
  final TaskRepository _repository;

  CreateTaskUseCase(this._repository);

  Future<Task> call(Task task) => _repository.createTask(task);
}
