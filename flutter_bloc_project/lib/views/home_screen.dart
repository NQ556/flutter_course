import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/common/manager/color_manager.dart';
import 'package:flutter_bloc_project/common/manager/font_manager.dart';
import 'package:flutter_bloc_project/common/manager/route_manager.dart';
import 'package:flutter_bloc_project/common/manager/string_manager.dart';
import 'package:flutter_bloc_project/cubit/note_cubit.dart';
import 'package:flutter_bloc_project/views/widgets/note_card.dart';
import 'package:flutter_bloc_project/views/widgets/rounded_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Color> colors = [
    ColorManager.color_1,
    ColorManager.color_2,
    ColorManager.color_3,
    ColorManager.color_4,
    ColorManager.color_5,
  ];

  @override
  void initState() {
    context.read<NoteCubit>().loadNotes();
    super.initState();
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
                StringManager.myNote,
                style: TextStyle(
                  fontFamily: FontFamilyConstants.fontFamily,
                  fontSize: 24,
                  fontWeight: FontWeightManager.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Expanded(
              child: BlocBuilder<NoteCubit, NoteState>(
                builder: (context, state) {
                  if (state is GetNotesState) {
                    return ListView.builder(
                      itemCount: state.notes.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            right: 20,
                            left: 20,
                          ),
                          child: NoteCard(
                            color: colors[index % colors.length],
                            note: state.notes[index],
                          ),
                        );
                      },
                    );
                  }

                  return Container();
                },
              ),
            ),

            //
            SizedBox(
              height: 50,
              child: RoundedButton(
                buttonText: StringManager.addNote,
                backgroundColor: ColorManager.color_5,
                textColor: Colors.white,
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.addNoteRoute,
                  );
                },
              ),
            ),

            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
