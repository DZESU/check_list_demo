import 'package:check_list_demo/domain/repositories/task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deleteTaskUseCaseProvider = Provider((ref)=>DeleteTaskUseCase(ref.read(taskRepositoryProvider)));
class DeleteTaskUseCase{
  final TaskRepository _repository;

  DeleteTaskUseCase(this._repository);

  Future<bool> call(int id)=>_repository.deleteTask(id);

}