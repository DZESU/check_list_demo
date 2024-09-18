
import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>?> getAllTasks();

  Future<Task?> getTaskById(int id);

  Future<Task> createTask(Task task);

  Future<Task> updateTask(Task task);

  Future<bool> deleteTask(int id);

  Future<void> deleteAllTasks();
}
