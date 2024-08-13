import 'package:flutter/material.dart';
import 'package:flutter_sqlite/common/manager/color_manager.dart';
import 'package:flutter_sqlite/common/manager/font_manager.dart';
import 'package:flutter_sqlite/common/manager/route_manager.dart';
import 'package:flutter_sqlite/model/note.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(
          context,
          Routes.viewNoteRoute,
          arguments: note,
        );
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: ColorManager.color_1,
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
                note.title,
                style: const TextStyle(
                  fontFamily: FontFamilyConstants.fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                note.content,
                style: const TextStyle(
                  fontFamily: FontFamilyConstants.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeightManager.regular,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
