import 'package:flutter/material.dart';
import 'package:flutter_widget/add_todo.dart';
import 'package:flutter_widget/todo.dart';
import 'package:flutter_widget/todo_box.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<ToDo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: Column(
                children: [
                  AddTodo(
                      titleController: titleController,
                      contentController: contentController),
                  TextButton(
                    onPressed: () {
                      ToDo newTodo = ToDo(
                        titleController.text.trim(),
                        contentController.text.trim(),
                      );

                      setState(() {
                        todos.add(newTodo);
                      });
                    },
                    child: const Text("Add"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TodoBox(
                      todo: todos[index],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
