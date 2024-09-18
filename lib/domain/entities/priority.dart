import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'priority.g.dart';

@HiveType(typeId: 1)
@freezed
enum Priority {
  @HiveField(0)
  low("Low", 0),
  @HiveField(1)
  medium("Medium", 1),
  @HiveField(2)
  high("High", 2),
  @HiveField(3)
  urgent("Urgent",3);

  const Priority(this.name, this.value);
  final int value;
  final String name;
}