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

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  Future<void> _addNewNote(String title, String content) async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      await databaseHelper.insertNote(
        Note(
          title: title,
          content: content,
        ),
      );

      titleController.clear();
      contentController.clear();
      showSnackBar(context, NotiManageer.addNoteSuccess);
    } on Exception catch (e) {
      showSnackBar(context, NotiManageer.addNoteFailure);
    }
  }

  void _onAddButtonPressed() {
    if (formKey.currentState!.validate()) {
      _addNewNote(
        titleController.text.trim(),
        contentController.text.trim(),
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
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
