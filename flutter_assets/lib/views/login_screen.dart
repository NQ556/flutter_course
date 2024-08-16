import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assets/manager/color_manager.dart';
import 'package:flutter_assets/manager/font_manager.dart';
import 'package:flutter_assets/manager/image_manager.dart';
import 'package:flutter_assets/manager/string_manager.dart';
import 'package:flutter_assets/model/user.dart';
import 'package:flutter_assets/widgets/auth_input.dart';
import 'package:flutter_assets/widgets/character_column.dart';
import 'package:flutter_assets/widgets/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(content),
        ),
      );
  }

  Future<User> login(String email, String password) async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/mock_users.json');
      final data = json.decode(response) as List;
      final users = data.map((e) => User.fromMap(e)).toList();
      final user = users.firstWhere(
          (user) => user.email == email && user.password == password);

      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> _onLoginPressed() async {
    if (formKey.currentState!.validate()) {
      try {
        User user = await login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        print("Success");
      } on Exception catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: CharacterColumn(
                        text: StringManager.japaneseName,
                        textStyle: TextStyle(
                          fontFamily: FontFamilyConstants.fontFamily_1,
                          fontSize: 40,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),

                  //
                  Image.asset(
                    ImageManager.sushi,
                    width: 266,
                    height: 266,
                  ),
                ],
              ),

              //
              const SizedBox(
                height: 30,
              ),

              //
              Text(
                StringManager.appName,
                style: TextStyle(
                  fontFamily: FontFamilyConstants.fontFamily_1,
                  fontSize: 40,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManager.primary,
                ),
              ),

              //
              Text(
                StringManager.slogan,
                style: TextStyle(
                  fontFamily: FontFamilyConstants.fontFamily_2,
                  fontSize: 18,
                  color: ColorManager.primary,
                ),
              ),

              //
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      //
                      AuthInput(
                        hintText: StringManager.email,
                        textEditingController: emailController,
                      ),

                      //
                      const SizedBox(
                        height: 20,
                      ),

                      //
                      AuthInput(
                        hintText: StringManager.password,
                        textEditingController: passwordController,
                        isObscure: true,
                      ),
                    ],
                  ),
                ),
              ),

              //
              const SizedBox(
                height: 30,
              ),

              //
              RoundedButton(
                buttonText: StringManager.login,
                backgroundColor: ColorManager.primary,
                textColor: Colors.white,
                onTap: _onLoginPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}
