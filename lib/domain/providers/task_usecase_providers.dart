import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/tast_data_source_provider.dart';
import '../../data/repositories/imp_task_repository.dart';
import '../repositories/task_repository.dart';
import '../usecases/create_task_usecase.dart';
import '../usecases/delete_all_tasks_usecase.dart';
import '../usecases/delete_task_usecase.dart';
import '../usecases/get_all_tasks_usecase.dart';
import '../usecases/get_task_by_id_usecase.dart';
import '../usecases/update_task_usecase.dart';

final taskRepositoryProvider = Provider<TaskRepository>(
    (ref) => ImpTaskRepository(ref.read(taskLocalStorageProvider)));

final createTaskUseCaseProvider =
    Provider((ref) => CreateTaskUseCase(ref.read(taskRepositoryProvider)));

final deleteAllTasksUseCaseProvider =
    Provider((ref) => DeleteAllTasksUseCase(ref.read(taskRepositoryProvider)));

final deleteTaskUseCaseProvider =
    Provider((ref) => DeleteTaskUseCase(ref.read(taskRepositoryProvider)));

final getAllTasksUseCaseProvider =
    Provider((ref) => GetAllTasksUseCase(ref.read(taskRepositoryProvider)));

final getTaskByIdUseCaseProvider =
    Provider((ref) => GetTaskByIdUseCase(ref.read(taskRepositoryProvider)));

final updateTaskUseCaseProvider =
    Provider((ref) => UpdateTaskUseCase(ref.read(taskRepositoryProvider)));
