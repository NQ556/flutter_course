import 'package:flutter/material.dart';
import 'package:flutter_provider/model/note.dart';
import 'package:flutter_provider/provider/note_provider.dart';
import 'package:flutter_provider/views/add_note_screen.dart';
import 'package:flutter_provider/views/home_screen.dart';
import 'package:flutter_provider/views/view_note_screen.dart';

class Routes {
  static const String homeRoute = "/home";
  static const String addNoteRoute = "/addNote";
  static const String viewNoteRoute = "/viewNote";
}

class ViewNoteArgs {
  final Note note;
  final NoteProvider noteProvider;

  ViewNoteArgs({
    required this.note,
    required this.noteProvider,
  });
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case Routes.addNoteRoute:
        if (routeSettings.arguments is NoteProvider) {
          final args = routeSettings.arguments as NoteProvider;

          return MaterialPageRoute(
            builder: (_) => AddNoteScreen(
              noteProvider: args,
            ),
          );
        }
        return unDefinedRoute();

      case Routes.viewNoteRoute:
        if (routeSettings.arguments is ViewNoteArgs) {
          final args = routeSettings.arguments as ViewNoteArgs;

          return MaterialPageRoute(
            builder: (_) => ViewNoteScreen(
              note: args.note,
              noteProvider: args.noteProvider,
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
