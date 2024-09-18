import 'package:check_list_demo/application/routes.dart';
import 'package:check_list_demo/presentation/task/providers/state/task_state.dart';
import 'package:check_list_demo/presentation/task/screens/task_screen.dart';
import 'package:go_router/go_router.dart';

import '../presentation/home/screens/home_screen.dart';

final appRouters = GoRouter(
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: Routes.createTask,
      builder: (context, state) => TaskScreen(
        taskMode: TaskMode.create,
      ),
    ),
    GoRoute(
      path: Routes.task,
      builder: (context, state) => TaskScreen(
        taskMode: TaskMode.view,
        taskId: int.tryParse(state.pathParameters["taskId"] ?? ''),
      ),
    ),
  ],
);
