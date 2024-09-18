import 'package:check_list_demo/const/ui_const.dart';
import 'package:check_list_demo/domain/entities/priority.dart';
import 'package:check_list_demo/presentation/home/providers/state/check_list_notifier.dart';
import 'package:check_list_demo/utility/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_design/moon_design.dart';

import '../providers/state/task_notifier.dart';
import '../providers/state/task_state.dart';

class TaskScreen extends ConsumerStatefulWidget {
  const TaskScreen({super.key, required this.taskMode, this.taskId});

  final TaskMode taskMode;
  final int? taskId;

  @override
  ConsumerState createState() => _TaskScreenState();
}

class _TaskScreenState extends ConsumerState<TaskScreen> {
  TaskNotifier get watchNotifier => ref.watch(taskNotifierProvider.notifier);

  TaskNotifier get readNotifier => ref.read(taskNotifierProvider.notifier);

  TaskState get watchState => ref.watch(taskNotifierProvider);

  TaskState get readState => ref.read(taskNotifierProvider);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      readNotifier.init(widget.taskMode, widget.taskId);
    });
    readNotifier.addListener((state) {
      if (state.status == TaskStatus.loaded) {
        titleController.text = state.task.title ?? titleController.text;
        descriptionController.text =
            state.task.description ?? descriptionController.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.moonColors?.gohan,
        foregroundColor: context.moonColors?.bulma,
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final viewPadding = MediaQuery.of(context).viewPadding;
    const loadingWidget = MoonCircularLoader();
    final body = Padding(
      padding: viewPadding,
      child: Padding(
        padding: UIEdgeInsert.lgHori,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _title(context)),
                MoonCheckbox(
                    tristate: false,
                    value: watchState.task.isFinished,
                    onChanged: (value) async {
                      await readNotifier.setIsFinished(value ?? false);
                      ref.read(checkListNotifierProvider.notifier).fetchTask();
                    })
              ],
            ),
            Expanded(child: _description(context)),
            Padding(
              padding: UIEdgeInsert.lgVert,
              child: _prioritiesWidget(context),
            ),
            Padding(
              padding: UIEdgeInsert.lgVert,
              child: _actions(context),
            ),
          ],
        ),
      ),
    );
    switch (watchState.status) {
      case TaskStatus.initial:
      case TaskStatus.loading:
        return loadingWidget;
      case TaskStatus.loaded:
        return body;
    }
  }

  Widget _actions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _cancelBtn(context),
        SizedBox(width: 16),
        if (watchState.mode == TaskMode.create) _saveBth(context),
        if (watchState.mode == TaskMode.edit ||
            watchState.mode == TaskMode.view)
          _updateBth(context),
      ],
    );
  }

  Widget _title(BuildContext context) {
    return TextField(
      controller: titleController,
      style: UITextStyle.header,
      autofocus: true,
      onChanged: readNotifier.setTitle,
      decoration: InputDecoration(
        hintText: "Title",
        border: InputBorder.none,
      ),
    );
  }

  Widget _description(BuildContext context) {
    return TextField(
      controller: descriptionController,
      style: UITextStyle.label,
      maxLines: null,
      minLines: 1,
      textInputAction: TextInputAction.newline,
      onChanged: readNotifier.setDescription,
      decoration: InputDecoration(
        hintText: "Description",
        border: InputBorder.none,
      ),
    );
  }

  Widget _cancelBtn(BuildContext context) {
    return MoonTextButton(onTap: context.pop, label: Text("Cancel"));
  }

  Widget _saveBth(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 16),
        MoonFilledButton(
            onTap: () async {
              // await readNotifier.addTask(
              //     title: titleController.text,
              //     description: descriptionController.text);
              await readNotifier.saveTask();
              _refreshList();
              if (context.mounted) {
                context.pop();
              }
            },
            leading: Icon(Icons.save),
            label: Text("Save")),
      ],
    );
  }

  Widget _prioritiesWidget(BuildContext context) {
    return Row(
      children: [
        const Row(
          children: [
            Icon(MoonIcons.generic_tag_16_light),
            Text("Priority:", style: UITextStyle.label),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: Priority.values
                .map((value) => Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: _priorityBtn(context, value, () {
                        readNotifier.setPriority(value);
                      }),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _priorityBtn(
      BuildContext context, Priority priority, VoidCallback onTab) {
    final isSelected = priority == watchState.task.priority;
    final color = UIHelper.getTagColor(context, priority);
    if (isSelected) {
      return MoonFilledButton(
        onTap: onTab,
        buttonSize: MoonButtonSize.sm,
        label: Text(priority.name),
        backgroundColor: color,
      );
    }
    return MoonOutlinedButton(
      onTap: onTab,
      buttonSize: MoonButtonSize.sm,
      label: Text(
        priority.name,
        style: TextStyle(color: color),
      ),
      borderColor: color,
    );
  }

  Widget _updateBth(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 16),
        MoonFilledButton(
            onTap: () async {
              await readNotifier.updateTask(
                  title: titleController.text,
                  description: descriptionController.text);
              _refreshList();
              if (context.mounted) {
                context.pop();
              }
            },
            leading: Icon(Icons.save),
            label: Text("Update")),
      ],
    );
  }

  void _refreshList() {
    ref.read(checkListNotifierProvider.notifier).fetchTask();
  }
}
