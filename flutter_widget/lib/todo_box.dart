import 'package:flutter/material.dart';
import 'package:flutter_widget/todo.dart';

class TodoBox extends StatelessWidget {
  const TodoBox({super.key, required this.todo});

  final ToDo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Column(
        children: [
          Text("Title: ${todo.title}"),
          Text("Content: ${todo.content}"),
        ],
      ),
    );
  }
}
