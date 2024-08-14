import 'package:flutter/material.dart';
import 'package:flutter_http/common/manager/color_manager.dart';
import 'package:flutter_http/common/manager/font_manager.dart';
import 'package:flutter_http/common/manager/route_manager.dart';
import 'package:flutter_http/common/manager/string_manager.dart';
import 'package:flutter_http/common/task_service.dart';
import 'package:flutter_http/task.dart';
import 'package:flutter_http/views/widgets/rounded_button.dart';
import 'package:flutter_http/views/widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  List<Color> colors = [
    ColorManager.color_1,
    ColorManager.color_2,
    ColorManager.color_3,
    ColorManager.color_4,
    ColorManager.color_5,
  ];

  @override
  void initState() {
    _loadTasks();
    super.initState();
  }

  void _loadTasks() async {
    TaskService taskService = TaskService();
    final result = await taskService.getTasks();

    setState(() {
      tasks = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      right: 20,
                      left: 20,
                    ),
                    child: TaskCard(
                      color: colors[index % colors.length],
                      task: tasks[index],
                    ),
                  );
                },
              ),
            ),

            //
            SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: RoundedButton(
                  buttonText: StringManager.addTask,
                  backgroundColor: ColorManager.color_5,
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.addTaskRoute,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
