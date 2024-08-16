import 'package:flutter/material.dart';
import 'package:flutter_sqlite/model/note.dart';
import 'package:flutter_sqlite/views/add_note_screen.dart';
import 'package:flutter_sqlite/views/home_screen.dart';
import 'package:flutter_sqlite/views/note_view_screen.dart';

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
            builder: (_) => NoteViewScreen(
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
