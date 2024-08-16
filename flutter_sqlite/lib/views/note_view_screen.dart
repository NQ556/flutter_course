import 'package:flutter/material.dart';
import 'package:flutter_sqlite/db/database_helper.dart';
import 'package:flutter_sqlite/common/manager/color_manager.dart';
import 'package:flutter_sqlite/common/manager/font_manager.dart';
import 'package:flutter_sqlite/common/manager/route_manager.dart';
import 'package:flutter_sqlite/common/manager/string_manager.dart';
import 'package:flutter_sqlite/model/note.dart';
import 'package:flutter_sqlite/common/show_snack_bar.dart';
import 'package:flutter_sqlite/views/widgets/input_field.dart';
import 'package:flutter_sqlite/views/widgets/rounded_button.dart';

class NoteViewScreen extends StatefulWidget {
  const NoteViewScreen({super.key, required this.note});
  final Note note;

  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    setState(() {
      titleController.text = widget.note.title;
      contentController.text = widget.note.content;
    });
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> _deleteNote(int id) async {
    try {
      await databaseHelper.deleteNote(id);
      showSnackBar(
        context,
        NotiManageer.deleteNoteSuccess,
      );
    } on Exception catch (e) {
      showSnackBar(
        context,
        NotiManageer.deleteNoteFailure,
      );
    }
  }

  Future<void> _updateNote(Note note) async {
    try {
      await databaseHelper.updateNote(note);
      showSnackBar(
        context,
        NotiManageer.updateNoteSuccess,
      );
    } on Exception catch (e) {
      showSnackBar(
        context,
        NotiManageer.updateNoteFailure,
      );
    }
  }

  void _onUpdatePressed() {
    String title = titleController.text.trim();
    String content = contentController.text.trim();

    if (formKey.currentState!.validate()) {
      _updateNote(
        Note(
          id: widget.note.id!,
          title: title,
          content: content,
        ),
      );
    }
  }

  void _onDeletePressed() {
    _deleteNote(widget.note.id!);
    Navigator.pushReplacementNamed(context, Routes.homeRoute);
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
                  StringManager.myNote,
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
                        hintText: StringManager.content,
                        textEditingController: contentController,
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
                buttonText: StringManager.edit,
                backgroundColor: ColorManager.color_5,
                textColor: Colors.white,
                onTap: _onUpdatePressed,
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
                onPressed: _onDeletePressed,
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
