import 'package:flutter/material.dart';
import 'package:flutter_widget/model/todo.dart';
import 'package:flutter_widget/views/view_todo_screen.dart';

class TodoBox extends StatelessWidget {
  const TodoBox({
    super.key,
    required this.todo,
    required this.themeMode,
    required this.onChangeTheme,
  });
  final ToDo todo;
  final ThemeMode themeMode;
  final VoidCallback onChangeTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ViewTodoScreen(
              toDo: todo,
              themeMode: themeMode,
              onChangeTheme: onChangeTheme,
            ),
          ),
        );
      },
      child: Container(
        color: Colors.black26,
        child: Column(
          children: [
            Text("Title: ${todo.title}"),
            Text("Content: ${todo.content}"),
          ],
        ),
      ),
    );
  }
}
