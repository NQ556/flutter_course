import 'package:flutter/material.dart';
import 'package:flutter_provider/common/manager/font_manager.dart';
import 'package:flutter_provider/common/manager/route_manager.dart';
import 'package:flutter_provider/model/note.dart';
import 'package:flutter_provider/provider/note_provider.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.color,
    required this.note,
    required this.noteProvider,
  });

  final Color color;
  final Note note;
  final NoteProvider noteProvider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(
          context,
          Routes.viewNoteRoute,
          arguments: ViewNoteArgs(
            note: note,
            noteProvider: noteProvider,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
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
                height: 5,
              ),
              Text(
                note.content,
                style: const TextStyle(
                  fontFamily: FontFamilyConstants.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
