import 'package:check_list_demo/domain/repositories/task_repository.dart';

import '../entities/task.dart';

class GetTaskByIdUseCase {
  final TaskRepository _repository;

  GetTaskByIdUseCase(this._repository);

  Future<Task?> call(int id) => _repository.getTaskById(id);
}
