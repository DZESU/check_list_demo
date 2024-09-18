import 'package:check_list_demo/domain/repositories/task_repository.dart';

import '../entities/task.dart';



class UpdateTaskUseCase{
  final TaskRepository _repository;

  UpdateTaskUseCase(this._repository);

  Future<Task> call(Task task)=>_repository.updateTask(task);
}