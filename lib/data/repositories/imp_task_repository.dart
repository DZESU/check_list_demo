import 'package:check_list_demo/data/data_sources/local/task_local_storage.dart';
import 'package:check_list_demo/domain/entities/task.dart';
import 'package:check_list_demo/domain/repositories/task_repository.dart';

class ImpTaskRepository implements TaskRepository {
  final TaskLocalStorage _localStorage;

  ImpTaskRepository(this._localStorage);

  @override
  Future<Task> createTask(Task task) => _localStorage.createTask(task);

  @override
  Future<bool> deleteTask(int id) => _localStorage.deleteTask(id);
  @override
  Future<void> deleteAllTasks() => _localStorage.deleteAllTasks();

  @override
  Future<List<Task>?> getAllTasks() => _localStorage.getAllTasks();

  @override
  Future<Task?> getTaskById(int id) => _localStorage.getTaskById(id);

  @override
  Future<Task> updateTask(Task task) => _localStorage.updateTask(task);
}
