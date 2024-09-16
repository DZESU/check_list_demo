import 'package:check_list_demo/domain/repositories/task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/task.dart';

final getAllTasksUseCaseProvider =
    Provider((ref) => GetAllTasksUseCase(ref.read(taskRepositoryProvider)));

class GetAllTasksUseCase {
  final TaskRepository _repository;

  GetAllTasksUseCase(this._repository);

  Future<List<Task>> call() => _repository.getAllTasks();
}
