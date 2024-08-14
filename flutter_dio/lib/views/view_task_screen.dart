import 'package:flutter/material.dart';
import 'package:flutter_dio/common/manager/color_manager.dart';
import 'package:flutter_dio/common/manager/font_manager.dart';
import 'package:flutter_dio/common/manager/route_manager.dart';
import 'package:flutter_dio/common/manager/string_manager.dart';
import 'package:flutter_dio/common/show_snack_bar.dart';
import 'package:flutter_dio/common/task_service.dart';
import 'package:flutter_dio/task.dart';
import 'package:flutter_dio/views/widgets/input_field.dart';
import 'package:flutter_dio/views/widgets/rounded_button.dart';

class ViewTaskScreen extends StatefulWidget {
  const ViewTaskScreen({super.key, required this.task});
  final Task task;

  @override
  State<ViewTaskScreen> createState() => _ViewTaskScreenState();
}

class _ViewTaskScreenState extends State<ViewTaskScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final taskService = TaskService();

  @override
  void initState() {
    setState(() {
      titleController.text = widget.task.title;
      bodyController.text = widget.task.body;
    });
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  void _updateTask(Task task) async {
    try {
      final result = await taskService.updateTask(task);
      showSnackBar(context, NotiManageer.updateTaskSuccess);
    } on Exception catch (e) {
      showSnackBar(context, NotiManageer.updateTaskFailure);
    }
  }

  Future<void> _deleteTask() async {
    try {
      await taskService.deleteTask();
      showSnackBar(context, NotiManageer.deleteTaskSuccess);
    } on Exception catch (e) {
      showSnackBar(context, NotiManageer.deleteTaskFailure);
    }
  }

  void _onDeleteButtonPressed() async {
    await _deleteTask();
    Navigator.pushReplacementNamed(context, Routes.homeRoute);
  }

  void _onUpdateButtonPressed() {
    if (formKey.currentState!.validate()) {
      final task = Task(
        userId: 1,
        title: titleController.text.trim(),
        body: bodyController.text.trim(),
      );

      _updateTask(task);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  StringManager.myTask,
                  style: TextStyle(
                    fontFamily: FontFamilyConstants.fontFamily,
                    fontSize: 24,
                    fontWeight: FontWeightManager.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              //
              const SizedBox(
                height: 20,
              ),

              //
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InputField(
                        hintText: StringManager.title,
                        textEditingController: titleController,
                        isLimitedLine: false,
                      ),
                    ),

                    //
                    const SizedBox(
                      height: 20,
                    ),

                    //
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InputField(
                        hintText: StringManager.body,
                        textEditingController: bodyController,
                        isLimitedLine: false,
                      ),
                    ),
                  ],
                ),
              ),

              //
              const SizedBox(
                height: 30,
              ),

              //
              RoundedButton(
                buttonText: StringManager.update,
                backgroundColor: ColorManager.color_5,
                textColor: Colors.white,
                onTap: _onUpdateButtonPressed,
              ),

              //
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.homeRoute,
                  );
                },
                child: const Text(
                  StringManager.back,
                  style: TextStyle(
                    fontFamily: FontFamilyConstants.fontFamily,
                    fontSize: 24,
                    fontWeight: FontWeightManager.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              //
              TextButton(
                onPressed: _onDeleteButtonPressed,
                child: const Text(
                  StringManager.delete,
                  style: TextStyle(
                    fontFamily: FontFamilyConstants.fontFamily,
                    fontSize: 24,
                    fontWeight: FontWeightManager.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
