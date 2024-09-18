import 'package:check_list_demo/shared/data/local/data_sources/storage_service.dart';

import '../../../domain/entities/task.dart';

class TaskLocalStorage {
  final StorageService<Task> storageService;
  static const String boxName = "task_box";

  TaskLocalStorage(this.storageService);

  Future<Task> createTask(Task task) async {
    return storageService.set(task.id, task);
  }

  Future<bool> deleteTask(int id) async {
    return storageService.remove(id);
  }

  Future<void> deleteAllTasks() async {
    return storageService.clear();
  }

  Future<Task> updateTask(Task task) async {
    return storageService.update(task.id, task);
  }

  Future<Task?> getTaskById(int id) async {
    return storageService.get(id);
  }

  Future<List<Task>?> getAllTasks() async {
    final values =  await storageService.getAll();
    return values;
  }
}
