import 'package:flutter/material.dart';
import 'package:flutter_widget/model/todo.dart';
import 'package:flutter_widget/widgets/add_todo.dart';
import 'package:flutter_widget/widgets/todo_box.dart';
import 'package:hive/hive.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({
    super.key,
    required this.themeMode,
    required this.onChangeTheme,
  });
  final ThemeMode themeMode;
  final VoidCallback onChangeTheme;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<ToDo> todos = [];
  bool isDarkMode = false;

  void _loadTodos() {
    final box = Hive.box<ToDo>('todos');
    setState(() {
      todos = box.values.toList();
    });
  }

  void _addTodo() {
    ToDo newTodo = ToDo(
      titleController.text.trim(),
      contentController.text.trim(),
    );

    final box = Hive.box<ToDo>('todos');
    box.add(newTodo);
    titleController.clear();
    contentController.clear();
    _loadTodos();
  }

  @override
  void initState() {
    super.initState();
    _loadTodos();
    print("TodoScreen: initState");
  }

  @override
  void didChangeDependencies() {
    print("TodoScreen: didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(TodoScreen oldWidget) {
    print("TodoScreen: didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print("TodoScreen: deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("TodoScreen: dispose");
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    print("TodoScreen: reassemble");
  }

  @override
  Widget build(BuildContext context) {
    print("TodoScreen: Build");
    ThemeMode currentTheme = widget.themeMode;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: Column(
                children: [
                  AddTodo(
                      titleController: titleController,
                      contentController: contentController),
                  Row(
                    children: [
                      TextButton(
                        onPressed: _addTodo,
                        child: const Text("Add"),
                      ),
                      IconButton(
                        onPressed: () {
                          currentTheme = currentTheme == ThemeMode.light
                              ? ThemeMode.dark
                              : ThemeMode.light;
                          widget.onChangeTheme();
                        },
                        icon: Icon(
                          widget.themeMode == ThemeMode.light
                              ? Icons.nightlight
                              : Icons.sunny,
                        ),
                      ),
                    ],
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
                      themeMode: currentTheme,
                      onChangeTheme: widget.onChangeTheme,
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
