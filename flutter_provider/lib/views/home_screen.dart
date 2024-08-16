import 'package:flutter/material.dart';
import 'package:flutter_provider/common/manager/color_manager.dart';
import 'package:flutter_provider/common/manager/font_manager.dart';
import 'package:flutter_provider/common/manager/route_manager.dart';
import 'package:flutter_provider/common/manager/string_manager.dart';
import 'package:flutter_provider/provider/note_provider.dart';
import 'package:flutter_provider/views/widgets/note_card.dart';
import 'package:flutter_provider/views/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

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
              child: ListView.builder(
                itemCount: noteProvider.notes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      right: 20,
                      left: 20,
                    ),
                    child: NoteCard(
                      color: colors[index % colors.length],
                      note: noteProvider.notes[index],
                      noteProvider: noteProvider,
                    ),
                  );
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
                    arguments: noteProvider,
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
