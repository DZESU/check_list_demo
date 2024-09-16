import 'package:check_list_demo/const/ui_const.dart';
import 'package:check_list_demo/presentation/home/providers/state/check_list_notifier.dart';
import 'package:check_list_demo/presentation/home/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/routes.dart';
import '../providers/state/check_list_state.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  CheckListNotifier get watchNotifier =>
      ref.watch(checkListNotifierProvider.notifier);

  CheckListNotifier get readNotifier =>
      ref.read(checkListNotifierProvider.notifier);

  CheckListState get watchState => ref.watch(checkListNotifierProvider);

  CheckListState get readState => ref.read(checkListNotifierProvider);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      readNotifier.fetchTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: _body(context),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "1",
            child: Icon(Icons.add),
            onPressed: () {
              context.push(Routes.task);
            },
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: UIEdgeInsert.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),
          _action(context),
          Expanded(
            child: _taskList(context),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    final taskCount = watchState.unfinishedTaskCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Welcome", style: UITextStyle.header),
        Text("$taskCount", style: UITextStyle.title)
      ],
    );
  }

  Widget _action(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DropdownButton<Sort>(
            underline: SizedBox(),
            value: watchState.sort,
            items: [
              DropdownMenuItem<Sort>(
                child: Text("Date"),
                value: Sort.date,
              ),
              DropdownMenuItem<Sort>(
                child: Text("Priority"),
                value: Sort.priority,
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                readNotifier.setSort(value);
              }
            }),
        // IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
        IconButton(
          onPressed: () {
            readNotifier.toggleOrder();
          },
          icon: Icon(watchState.order == Order.ascending
              ? Icons.arrow_circle_up_outlined
              : Icons.arrow_circle_down_outlined),
        ),
      ],
    );
  }

  Widget _taskList(BuildContext context) {
    final tasks = watchState.tasks;
    return ListView.separated(
        itemBuilder: _itemBuilder,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemCount: tasks.length);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final tasks = watchState.tasks;
    final task = tasks[index];
    return TaskTile(
      task: task,
      onClicked: () {},
      onBthDeleteClicked: () {
        if (task.id != null) {
          readNotifier.deleteTask(task.id!);
        }
      },
    );
  }
}
