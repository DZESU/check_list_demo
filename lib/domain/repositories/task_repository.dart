import 'package:check_list_demo/data/data_sources/local/task_local_storage.dart';
import 'package:check_list_demo/data/repositories/imp_task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/task.dart';

final taskRepositoryProvider = Provider<TaskRepository>(
    (ref) => ImpTaskRepository(ref.read(taskLocalStorageProvider)));

abstract class TaskRepository {
  Future<List<Task>> getAllTasks();

  Future<Task?> getTaskById(int id);

  Future<Task> createTask(Task task);

  Future<Task> updateTask(Task task);

  Future<bool> deleteTask(int id);

  Future<bool> deleteAllTasks();
}
