import 'package:flutter/material.dart';
import 'package:flutter_sqlite/db/database_helper.dart';
import 'package:flutter_sqlite/common/manager/color_manager.dart';
import 'package:flutter_sqlite/common/manager/font_manager.dart';
import 'package:flutter_sqlite/common/manager/route_manager.dart';
import 'package:flutter_sqlite/common/manager/string_manager.dart';
import 'package:flutter_sqlite/model/note.dart';
import 'package:flutter_sqlite/views/widgets/note_card.dart';
import 'package:flutter_sqlite/views/widgets/rounded_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];

  Future<void> loadNotes() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    databaseHelper.loadNotes();
    final result = await databaseHelper.loadNotes();
    setState(() {
      notes = result;
    });
  }

  @override
  void initState() {
    loadNotes();
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
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      right: 20,
                      left: 20,
                    ),
                    child: NoteCard(
                      note: notes[index],
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
