import 'package:check_list_demo/shared/data/local/data_sources/storage_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService<T> implements StorageService<T> {
  final Box<T> box;

  HiveService(this.box);

  @override
  Future<void> clear() async {
    await box.clear();
  }

  @override
  Future<T?> get(key) async {
    return box.get(key);
  }

  @override
  Future<List<T>?> getAll() async {
    return box.values.toList();
  }

  @override
  Future<bool> has(key) async {
    return box.containsKey(key);
  }

  @override
  Future<bool> remove(key) async {
    box.delete(key);
    return true;
  }

  @override
  Future<T> set(key, data) async {
    await box.put(key, data);
    return data;
  }

  @override
  Future<T> update(key, data) async {
    await box.put(key, data);
    return data;
  }
}
