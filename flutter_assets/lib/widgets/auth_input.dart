import 'package:flutter/material.dart';
import 'package:flutter_assets/manager/color_manager.dart';
import 'package:flutter_assets/manager/font_manager.dart';

class AuthInput extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final bool isObscure;

  const AuthInput({
    super.key,
    required this.hintText,
    required this.textEditingController,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: FontFamilyConstants.fontFamily_2,
          fontSize: 18,
          color: ColorManager.primary,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.primary,
            width: 1.5,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      obscureText: isObscure,
      style: TextStyle(
        fontFamily: FontFamilyConstants.fontFamily_2,
        fontSize: 18,
        color: ColorManager.primary,
      ),
    );
  }
}
