/// Storage service interface
abstract class StorageService<T> {


  Future<bool> remove(String boxName, dynamic key);

  Future<T?> get(String boxName, dynamic key);

  Future<List<T>?> getAll(String boxName);

  Future<T> set(String boxName, dynamic key, T data);

  Future<T> update(String boxName, dynamic key, T data);

  Future<void> clear(String boxName);

  Future<bool> has(String boxName, dynamic key);
}
