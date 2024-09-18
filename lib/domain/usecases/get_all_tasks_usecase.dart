import 'package:check_list_demo/domain/repositories/task_repository.dart';

import '../entities/task.dart';


class GetAllTasksUseCase {
  final TaskRepository _repository;

  GetAllTasksUseCase(this._repository);

  Future<List<Task>?> call() => _repository.getAllTasks();
}
