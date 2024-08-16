import 'package:flutter/material.dart';
import 'package:flutter_hive/common/manager/color_manager.dart';
import 'package:flutter_hive/common/manager/font_manager.dart';
import 'package:flutter_hive/common/manager/route_manager.dart';
import 'package:flutter_hive/common/manager/string_manager.dart';
import 'package:flutter_hive/model/note.dart';
import 'package:flutter_hive/views/widgets/input_field.dart';
import 'package:flutter_hive/views/widgets/rounded_button.dart';
import 'package:hive/hive.dart';

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
  final box = Hive.box<Note>('notes');

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

  void _updateButtonPressed() {
    box.put(
      widget.note.key,
      Note(
        title: titleController.text.trim(),
        content: contentController.text.trim(),
      ),
    );
  }

  void _onDeleteButtonPressed() {
    box.delete(widget.note.key);
    Navigator.pushReplacementNamed(
      context,
      Routes.homeRoute,
    );
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
                onTap: _updateButtonPressed,
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
