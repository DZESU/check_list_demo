import 'package:check_list_demo/const/ui_const.dart';
import 'package:check_list_demo/utility/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moon_design/moon_design.dart';

import '../../../domain/entities/task.dart';
import 'x_card.dart';

class TaskTile extends ConsumerStatefulWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onClicked,
    required this.onBthDeleteClicked,
    required this.onCheckValueChange,
  });

  final Task task;
  final VoidCallback onClicked;
  final VoidCallback onBthDeleteClicked;
  final ValueChanged<bool?> onCheckValueChange;

  @override
  ConsumerState createState() => _TaskTileState();
}

class _TaskTileState extends ConsumerState<TaskTile> {

  @override
  void didUpdateWidget(covariant TaskTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.task != widget.task){
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final title = task.title;
    final createdDate = task.createdDate;
    final dateFormat = DateFormat.Md().add_jms();
    final timeStr = createdDate != null ? dateFormat.format(createdDate) : null;
    final priorityName = task.priority?.name;
    final priorityColor = UIHelper.getTagColor(context, task.priority);

    return GestureDetector(
      onTap: widget.onClicked,
      child: XCard(
        padding: UIEdgeInsert.none,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoonCheckbox(value: widget.task.isFinished, onChanged: widget.onCheckValueChange),
                Expanded(
                    child: Padding(
                  padding: UIEdgeInsert.md,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? '',
                        style: UITextStyle.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (priorityName != null)
                            MoonTag(
                              trailing: Icon(
                                MoonIcons.generic_tag_16_light,
                                color: context.moonColors?.goten,
                              ),
                              tagSize: MoonTagSize.xs,
                              label: Text(
                                priorityName,
                                style:
                                    TextStyle(color: context.moonColors?.goten),
                              ),
                              backgroundColor: priorityColor,
                            ),
                          if (timeStr != null)
                            Text(
                              timeStr,
                              style: UITextStyle.caption
                                  .copyWith(color: UIColors.caption1),
                            ),
                        ],
                      )
                    ],
                  ),
                )),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: MoonButton.icon(
                  iconColor: context.moonColors?.jiren,
                  onTap: widget.onBthDeleteClicked,
                  icon: Icon(Icons.remove_circle)),
            )
          ],
        ),
      ),
    );
  }
}