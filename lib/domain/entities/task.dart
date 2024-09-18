import 'dart:math';

import 'package:check_list_demo/domain/entities/priority.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'task.freezed.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
@freezed
class Task with _$Task {
  const factory Task({
    @HiveField(0) int? id,
    @HiveField(1) String? title,
    @HiveField(2) String? description,
    @HiveField(3) @Default(false)bool? isFinished,
    @HiveField(4) @Default(Priority.medium) Priority? priority,
    @HiveField(5) DateTime? createdDate,
    @HiveField(6) DateTime? updatedDate,
  }) = _Task;

  factory Task.random({int? id}) {
    final tid = id ?? Random().nextInt(1000);
    return Task(id: tid, title: "$tid title", createdDate: DateTime.now());
  }
}
