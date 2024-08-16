import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/core/manager/color_manager.dart';
import 'package:flutter_bloc_project/core/manager/font_manager.dart';
import 'package:flutter_bloc_project/core/manager/route_manager.dart';
import 'package:flutter_bloc_project/core/manager/string_manager.dart';
import 'package:flutter_bloc_project/core/common/show_snack_bar.dart';
import 'package:flutter_bloc_project/cubit/note_cubit.dart';
import 'package:flutter_bloc_project/domain/entity/note.dart';
import 'package:flutter_bloc_project/presentation/widgets/input_field.dart';
import 'package:flutter_bloc_project/presentation/widgets/rounded_button.dart';

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

  void _onAddButtonPressed() {
    if (formKey.currentState!.validate()) {
      final note = Note(
        id: null,
        title: titleController.text.trim(),
        content: contentController.text.trim(),
      );

      context.read<NoteCubit>().addNote(note);
      titleController.clear();
      contentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<NoteCubit, NoteState>(
            listener: (context, state) {
              if (state is AddNoteSuccessState) {
                showSnackBar(
                  context,
                  NotiManageer.addNoteSuccess,
                );
              } else if (state is NoteFailureState) {
                showSnackBar(
                  context,
                  NotiManageer.addNoteFailure,
                );
              }
            },
            builder: (context, state) {
              return Column(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
