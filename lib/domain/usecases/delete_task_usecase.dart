import 'package:check_list_demo/domain/repositories/task_repository.dart';

class DeleteTaskUseCase{
  final TaskRepository _repository;

  DeleteTaskUseCase(this._repository);

  Future<bool> call(int id)=>_repository.deleteTask(id);

}