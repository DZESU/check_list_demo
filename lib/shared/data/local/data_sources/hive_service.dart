import 'package:check_list_demo/shared/data/local/data_sources/storage_service.dart';
import 'package:hive_flutter/hive_flutter.dart';



class HiveService<T> implements StorageService<T>{

  Future<Box<T>> getBox(String boxName) async{
    Box<T> box;
    if (Hive.isBoxOpen(boxName)) {
      box = Hive.box<T>(boxName);
    }else{
      box = await Hive.openBox<T>(boxName);
    }
    return box;
  }


  @override
  Future<void> clear(String boxName) async{
    final box = await getBox(boxName);
    await box.clear();
  }

  @override
  Future<T?> get(String boxName, key) async {
    final box = await getBox(boxName);
    return box.get(key);
  }

  @override
  Future<List<T>?> getAll(String boxName) async{
    final box = await getBox(boxName);
    return box.values.toList();
  }

  @override
  Future<bool> has(String boxName, key) async{
    final box = await getBox(boxName);
    return box.containsKey(key);
  }

  @override
  Future<bool> remove(String boxName, key) async{
    final box = await getBox(boxName);
    box.delete(key);
    return true;
  }

  @override
  Future<T> set(String boxName, key, data) async{
    final box = await getBox(boxName);
    await box.put(key, data);
    return data;
  }

  @override
  Future<T> update(String boxName, key, data) async{
    final box = await getBox(boxName);
    await box.put(key, data);
    return data;
  }

}