import 'package:flutter/material.dart';
import 'package:flutter_widget/model/todo.dart';
import 'package:flutter_widget/views/todo_screen.dart';

class ViewTodoScreen extends StatelessWidget {
  const ViewTodoScreen({
    super.key,
    required this.toDo,
    required this.themeMode,
    required this.onChangeTheme,
  });
  final ToDo toDo;
  final ThemeMode themeMode;
  final VoidCallback onChangeTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Title: ${toDo.title}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                "Content: ${toDo.content}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => TodoScreen(
                        themeMode: themeMode,
                        onChangeTheme: onChangeTheme,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Back",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
