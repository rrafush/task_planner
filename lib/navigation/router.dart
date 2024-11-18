import 'package:flutter/material.dart';
import 'package:simple_to_do_app/navigation/router_path.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/task_list_screen.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouterPath.home:
      return MaterialPageRoute(
        builder: (_) => const TaskListScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const TaskListScreen(),
        settings: settings,
      );
  }
}
