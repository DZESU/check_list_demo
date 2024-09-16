import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/entities/task.dart';

final taskLocalStorageProvider = Provider((ref)=>TaskLocalStorage());

class TaskLocalStorage {
  static const String boxName = "task_box";

  Future<Box<Task>> _getBox() async{
    if (Hive.isBoxOpen(boxName)) {
      return Future.value(Hive.box<Task>(boxName));
    }
    return Hive.openBox<Task>(boxName);
  }

  Future<Task> createTask(Task task) async {
    final box = await _getBox();
    await box.put(task.id, task);
    return task;
  }

  Future<bool> deleteTask(int id) async {
    final box = await _getBox();
    box.delete(id);
    return true;
  }

  Future<bool> deleteAllTasks() async {
    final box = await _getBox();
    await box.clear();
    return true;
  }



  Future<Task> updateTask(Task task) async {
    final box = await _getBox();
    if (box.containsKey(task.id)) {
      box.put(task.id, task);
    } else {
      return createTask(task);
    }
    return task;
  }

  Future<Task?> getTaskById(int id) async {
    final box = await _getBox();
    return box.get(id);
  }

  Future<List<Task>> getAllTask() async {
    final box = await _getBox();
    return box.values.toList();
  }
}
