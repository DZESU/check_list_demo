import 'package:check_list_demo/const/ui_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/task.dart';

class TaskTile extends ConsumerStatefulWidget {
  const TaskTile(
      {super.key,
      required this.task,
      required this.onClicked,
      required this.onBthDeleteClicked});

  final Task task;
  final VoidCallback onClicked;
  final VoidCallback onBthDeleteClicked;

  @override
  ConsumerState createState() => _TaskTileState();
}

class _TaskTileState extends ConsumerState<TaskTile> {
  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final title = task.title;
    final description = task.description;
    final isFinished = task.isFinished ?? false;
    final createdDate = task.createdDate;
    final dateFormat = DateFormat.jms();
    final timeFormat = DateFormat.Hms();
    final timeStr = createdDate != null ? timeFormat.format(createdDate) : null;
    final priorityName = task.priority?.name;
    return GestureDetector(
      onTap: widget.onClicked,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(value: false, onChanged: (value) {}),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  style: UITextStyle.title,
                ),
                if (description != null)
                  Text(
                    description,
                    style: UITextStyle.label,
                  ),
                if (timeStr != null)
                  Text(
                    timeStr,
                    style: UITextStyle.caption,
                  ),
                if(priorityName != null)
                Chip(label: Text(priorityName)),
              ],
            )),
            IconButton(
                onPressed: widget.onBthDeleteClicked,
                icon: Icon(Icons.remove_circle))
          ],
        ),
      ),
    );
  }
}
