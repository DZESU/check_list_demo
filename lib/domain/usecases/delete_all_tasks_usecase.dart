import 'package:check_list_demo/domain/repositories/task_repository.dart';


class DeleteAllTasksUseCase {
  final TaskRepository _repository;

  DeleteAllTasksUseCase(this._repository);

  Future<void> call() => _repository.deleteAllTasks();
}
