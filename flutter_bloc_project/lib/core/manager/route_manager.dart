import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/domain/entity/note.dart';
import 'package:flutter_bloc_project/presentation/views/add_note_screen.dart';
import 'package:flutter_bloc_project/presentation/views/home_screen.dart';
import 'package:flutter_bloc_project/presentation/views/view_note_screen.dart';

class Routes {
  static const String homeRoute = "/home";
  static const String addNoteRoute = "/addNote";
  static const String viewNoteRoute = "/viewNote";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case Routes.addNoteRoute:
        return MaterialPageRoute(
          builder: (_) => const AddNoteScreen(),
        );

      case Routes.viewNoteRoute:
        if (routeSettings.arguments is Note) {
          final args = routeSettings.arguments as Note;

          return MaterialPageRoute(
            builder: (_) => ViewNoteScreen(
              note: args,
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
