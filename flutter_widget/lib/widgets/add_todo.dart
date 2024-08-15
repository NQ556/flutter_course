import 'package:flutter/material.dart';

class AddTodo extends StatelessWidget {
  const AddTodo(
      {super.key,
      required this.titleController,
      required this.contentController});

  final TextEditingController titleController;
  final TextEditingController contentController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: "Todo Title",
          ),
        ),
        TextField(
          controller: contentController,
          decoration: const InputDecoration(
            labelText: "Todo Content",
          ),
        )
      ],
    );
  }
}
