import 'package:check_list_demo/const/ui_const.dart';
import 'package:check_list_demo/presentation/home/providers/state/check_list_notifier.dart';
import 'package:check_list_demo/presentation/home/widgets/empty_placeholder.dart';
import 'package:check_list_demo/presentation/home/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:moon_design/moon_design.dart';

import '../../../application/routes.dart';
import '../../../domain/entities/task.dart';
import '../providers/state/check_list_state.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  CheckListNotifier get watchNotifier =>
      ref.watch(checkListNotifierProvider.notifier);

  CheckListNotifier get readNotifier =>
      ref.read(checkListNotifierProvider.notifier);

  CheckListState get watchState => ref.watch(checkListNotifierProvider);

  CheckListState get readState => ref.read(checkListNotifierProvider);

  late TabController _tabController;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      readNotifier.fetchTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
      ),
      body: _body(context),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            backgroundColor: context.moonColors?.piccolo,
            foregroundColor: context.moonColors?.goten,
            onPressed: () {
              context.push(Routes.createTask);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: UIEdgeInsert.lgHori,
          child: _header(context),
        ),
        Padding(
          padding: UIEdgeInsert.lgHori.add(UIEdgeInsert.mdVert),
          child: _chart(context),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(child: _tab(context)),
            const SizedBox(width: 8),
            _action(context),
          ],
        ),
        Expanded(
          child: _taskPageView(context),
        ),
      ],
    );
  }

  Widget _header(BuildContext context) {
    final todoTaskCount = watchState.todoTasksCount;
    final totalTaskCount = watchState.totalTasksCount;
    String message;
    if(todoTaskCount > 1){
      message = "📋You have $todoTaskCount to finish";
    }else{
      if(totalTaskCount > 1) {
        message = "🏆You completed all your task";
      }else{
        message = '';
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Welcome back!🐼", style: UITextStyle.header),
        Text(message,
            style: UITextStyle.label.copyWith(color: UIColors.label1))
      ],
    );
  }

  Widget _tab(BuildContext context){
    return MoonTabBar(
      tabController: _tabController,
      tabs: const [
        MoonTab(
            label: Text("TODO"),
            leading: Icon(MoonIcons.files_clipboard_16_light)),
        MoonTab(
            label: Text("Archive"),
            leading: Icon(MoonIcons.mail_box_16_light)),
      ],
      isExpanded: true,
      onTabChanged: (value) {
        _pageController.animateToPage(value,
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      },
    );
  }

  Widget _chart(BuildContext context) {
    final archiveTasksCount = watchState.archiveTasksCount;
    final todoTasksCount = watchState.todoTasksCount;
    var total = watchState.totalTasksCount;
    double value = 0;
    if (total > 0) {
      value = (archiveTasksCount / total);
    }
    final numberFormat = NumberFormat("#.#");
    final percentage = numberFormat.format(value * 100);
    return XCard(
        child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Acrchive",
              style: UITextStyle.title.copyWith(fontWeight: FontWeight.w500),
            ),
            Text("Completed: $archiveTasksCount Task${archiveTasksCount > 1 ? "s":""}"),
            Text("Todo: $todoTasksCount Task${todoTasksCount > 1 ? "s":""}"),
          ],
        ),
        const Spacer(),
        Stack(
          alignment: Alignment.center,
          children: [
            MoonCircularProgress(
              value: value,
              circularProgressSize: MoonCircularProgressSize.lg,
              strokeWidth: 8,
            ),
            Text("$percentage%", style: UITextStyle.caption.copyWith(color: UIColors.caption1),)
          ],
        ),
      ],
    ));
  }

  Widget _action(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _FilterWidget(
          values: watchState.sortValues,
          selectedValue: watchState.sort,
          onValueChanged: (value) {
            readNotifier.setSort(value);
          },
        ),
        // IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
        MoonButton.icon(
          iconColor: context.moonColors?.trunks,
          onTap: () {
            readNotifier.toggleOrder();
          },
          icon: Icon(watchState.order == Order.ascending
              ? Icons.arrow_circle_down_outlined
              : Icons.arrow_circle_up_outlined),
        ),
      ],
    );
  }

  Widget _taskPageView(BuildContext context) {
    final todoTasks = watchState.todoTasks;
    final archiveTasks = watchState.archiveTasks;
    return PageView(
      controller: _pageController,
      onPageChanged: (value) {
        _tabController.animateTo(value);
      },
      children: [
        _taskList(context, todoTasks),
        _taskList(context, archiveTasks),
      ],
    );
  }

  Widget _taskList(BuildContext context, List<Task> tasks) {
    if (tasks.isEmpty) {
      return const EmptyPlaceholder();
    }
    return ListView.separated(
        padding: UIEdgeInsert.lg,
        itemBuilder: (context, index) => _itemBuilder(context, tasks[index]),
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemCount: tasks.length);
  }

  Widget _itemBuilder(BuildContext context, Task task) {
    return TaskTile(
      task: task,
      onCheckValueChange: (value) => readNotifier.updateTask(value, task),
      onClicked: () => context.push(Routes.taskById(task.id)),
      onBthDeleteClicked: () {
        if (task.id != null) {
          readNotifier.deleteTask(task.id!);
        }
      },
    );
  }
}

class _FilterWidget extends StatefulWidget {
  const _FilterWidget(
      {this.values = const [],
      this.selectedValue,
      this.onValueChanged});

  final List<Sort> values;
  final Sort? selectedValue;
  final Function(Sort value)? onValueChanged;

  @override
  State<_FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<_FilterWidget> {
  bool _show = false;
  late Sort _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.selectedValue ?? widget.values.first;
    if (widget.selectedValue == null) {
      // Callback to set value when current value is null.
      widget.onValueChanged?.call(_currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MoonDropdown(
      show: _show,
      onTapOutside: () => setState(() {
        _show = false;
      }),
      content: Column(
        children: widget.values
            .map((value) => MoonMenuItem(
                onTap: () {
                  setState(() {
                    _show = false;
                    _currentValue = value;
                    widget.onValueChanged?.call(value);
                  });
                },
                label: Text(value.name)))
            .toList(),
      ),
      child: MoonOutlinedButton(
        buttonSize: MoonButtonSize.sm,
        leading: const Icon(Icons.arrow_drop_down),
        onTap: () => setState(() => _show = !_show),
        label: Text(_currentValue.name),
      ),
    );
  }
}
