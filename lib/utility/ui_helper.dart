
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../domain/entities/priority.dart';

class UIHelper{
  UIHelper._();

  static Color? getTagColor(BuildContext context, Priority? priority) {
    switch (priority) {
      case Priority.medium:
        return context.moonColors?.roshi60;
      case Priority.high:
        return context.moonColors?.dodoria60;
      case Priority.urgent:
        return context.moonColors?.krillin60;
      case Priority.low:
      default:
        return context.moonColors?.whis60;
    }
  }

}