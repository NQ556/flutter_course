import 'package:flutter/material.dart';
import 'package:flutter_shared_preference/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "";
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void initState() {
    _loadName();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> _loadName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString("name") ?? "No name found";
    });
  }

  Future<void> _saveName(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("name", name);
    nameController.clear();
  }

  void _onSaveButtonPressed() {
    if (formKey.currentState!.validate()) {
      _saveName(nameController.text.trim());
      _loadName();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            Form(
              key: formKey,
              child: InputField(
                hintText: "Name",
                textEditingController: nameController,
              ),
            ),
            TextButton(
              onPressed: _onSaveButtonPressed,
              child: const Text(
                "Save name",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
