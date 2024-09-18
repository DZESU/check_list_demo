/// Storage service interface
abstract class StorageService<T> {


  Future<bool> remove(dynamic key);

  Future<T?> get(dynamic key);

  Future<List<T>?> getAll();

  Future<T> set(dynamic key, T data);

  Future<T> update(dynamic key, T data);

  Future<void> clear();

  Future<bool> has(dynamic key);
}
