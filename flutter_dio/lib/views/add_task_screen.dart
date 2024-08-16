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

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  void _createTask(Task task) async {
    try {
      TaskService taskService = TaskService();
      final result = await taskService.createTask(task);
      showSnackBar(context, NotiManageer.addTaskSuccess);
    } on Exception catch (e) {
      showSnackBar(context, NotiManageer.addTaskFailure);
    }
  }

  void _onAddButtonPressed() {
    if (formKey.currentState!.validate()) {
      final task = Task(
        userId: 1,
        title: titleController.text.trim(),
        body: bodyController.text.trim(),
      );

      _createTask(task);
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
                  StringManager.addTask,
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
                buttonText: StringManager.addTask,
                backgroundColor: ColorManager.color_5,
                textColor: Colors.white,
                onTap: _onAddButtonPressed,
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
            ],
          ),
        ),
      ),
    );
  }
}
