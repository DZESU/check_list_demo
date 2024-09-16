
import 'package:check_list_demo/const/ui_const.dart';
import 'package:check_list_demo/presentation/home/providers/state/check_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/state/task_notifier.dart';
import '../providers/state/task_state.dart';

class TaskScreen extends ConsumerStatefulWidget {
  const TaskScreen({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: UIEdgeInsert.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(context),
          Expanded(child: _description(context)),
          _actions(context),
        ],
      ),
    );
  }

  Widget _actions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _cancelBtn(context),
        SizedBox(width: 16),
        if (watchState.mode == TaskMode.create) _saveBth(context),
      ],
    );
  }

  Widget _title(BuildContext context) {
    return TextField(
      controller: titleController,
      style: UITextStyle.title,
      decoration: InputDecoration(
        hintText: "Title",
        border: InputBorder.none,
      ),
    );
  }

  Widget _description(BuildContext context) {
    return TextField(
      controller: descriptionController,
      style: UITextStyle.body,
      decoration: InputDecoration(
        hintText: "Description",
        border: InputBorder.none,
      ),
    );
  }

  Widget _cancelBtn(BuildContext context) {
    return TextButton(onPressed: context.pop, child: Text("Cancel"));
  }

  Widget _saveBth(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 16),
        FilledButton.icon(
            onPressed: () async{
              await readNotifier.addTask(
                  title: titleController.text,
                  description: descriptionController.text);
              _refreshList();
              context.pop();
            },
            icon: Icon(Icons.save),
            label: Text("Save")),
      ],
    );
  }

  Widget _updateBth(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 16),
        FilledButton.icon(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.save),
            label: Text("Update")),
      ],
    );
  }

  void _refreshList(){
    ref.read(checkListNotifierProvider.notifier).fetchTask();
  }
}
