import 'package:flutter/material.dart';
import 'package:flutter_isar/common/database_helper.dart';
import 'package:flutter_isar/common/manager/color_manager.dart';
import 'package:flutter_isar/common/manager/font_manager.dart';
import 'package:flutter_isar/common/manager/route_manager.dart';
import 'package:flutter_isar/common/manager/string_manager.dart';
import 'package:flutter_isar/common/show_snack_bar.dart';
import 'package:flutter_isar/model/note.dart';
import 'package:flutter_isar/views/widgets/input_field.dart';
import 'package:flutter_isar/views/widgets/rounded_button.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> _addNewNote(Note note) async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      await databaseHelper.addNote(note);
      showSnackBar(context, NotiManageer.addNoteSuccess);
    } on Exception catch (e) {
      showSnackBar(context, NotiManageer.addNoteFailure);
    }
  }

  void _onAddButtonPressed() {
    if (formKey.currentState!.validate()) {
      final note = Note()
        ..title = titleController.text.trim()
        ..content = contentController.text.trim();

      _addNewNote(note);

      titleController.clear();
      contentController.clear();
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
                  StringManager.addNote,
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
                buttonText: StringManager.addNote,
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
