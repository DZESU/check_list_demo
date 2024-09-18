import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/task.dart';
import '../../shared/data/local/data_sources/hive_service.dart';
import '../../shared/data/local/data_sources/storage_service.dart';
import '../data_sources/local/task_local_storage.dart';

final taskHiveBox = Provider(
    (ref) => HiveService<Task>(Hive.box<Task>(TaskLocalStorage.boxName)));
final taskLocalStorageProvider = Provider(
    (ref) => TaskLocalStorage(ref.read<StorageService<Task>>(taskHiveBox)));
