import 'package:check_list_demo/application/log_observer.dart';
import 'package:check_list_demo/data/data_sources/local/task_local_storage.dart';
import 'package:check_list_demo/domain/entities/priority.dart';
import 'package:check_list_demo/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'application/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<Task>(TaskLocalStorage.boxName);
  runApp(ProviderScope(observers: [LogObserver()], child: const App()));
}
