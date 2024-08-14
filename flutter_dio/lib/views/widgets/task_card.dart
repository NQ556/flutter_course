import 'package:flutter/material.dart';
import 'package:flutter_dio/common/manager/font_manager.dart';
import 'package:flutter_dio/common/manager/route_manager.dart';
import 'package:flutter_dio/task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.color,
    required this.task,
  });

  final Color color;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(
          context,
          Routes.viewTaskRoute,
          arguments: task,
        );
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: const TextStyle(
                  fontFamily: FontFamilyConstants.fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeightManager.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                task.body,
                style: const TextStyle(
                  fontFamily: FontFamilyConstants.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeightManager.regular,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
