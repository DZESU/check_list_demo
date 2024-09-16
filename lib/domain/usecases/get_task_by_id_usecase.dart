import 'package:check_list_demo/domain/repositories/task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/task.dart';

final getTaskByIdUseCaseProvider =
    Provider((ref) => GetTaskByIdUseCase(ref.read(taskRepositoryProvider)));

class GetTaskByIdUseCase {
  final TaskRepository _repository;

  GetTaskByIdUseCase(this._repository);

  Future<Task?> call(int id) => _repository.getTaskById(id);
}
