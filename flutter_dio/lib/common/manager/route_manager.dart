import 'package:flutter/material.dart';
import 'package:flutter_dio/task.dart';
import 'package:flutter_dio/views/add_task_screen.dart';
import 'package:flutter_dio/views/home_screen.dart';
import 'package:flutter_dio/views/view_task_screen.dart';

class Routes {
  static const String homeRoute = "/home";
  static const String addTaskRoute = "/addTask";
  static const String viewTaskRoute = "/viewTask";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case Routes.addTaskRoute:
        return MaterialPageRoute(
          builder: (_) => const AddTaskScreen(),
        );

      case Routes.viewTaskRoute:
        if (routeSettings.arguments is Task) {
          final args = routeSettings.arguments as Task;

          return MaterialPageRoute(
            builder: (_) => ViewTaskScreen(
              task: args,
            ),
          );
        }
        return unDefinedRoute();

      default:
        return unDefinedRoute();
    }
  }
}

Route<dynamic> unDefinedRoute() {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      appBar: AppBar(
        title: const Text("No Route Found"),
      ),
      body: const Center(
        child: Text("No Route Found"),
      ),
    ),
  );
}
