import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'priority.g.dart';

@HiveType(typeId: 1)
@freezed
enum Priority {
  @HiveField(0)
  low("Low"),
  @HiveField(1)
  medium("Medium"),
  @HiveField(2)
  high("High"),
  @HiveField(3)
  urgent("Urgent");

  const Priority(this.name);
  final String name;
}