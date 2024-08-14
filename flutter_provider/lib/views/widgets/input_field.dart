import 'package:flutter/material.dart';
import 'package:flutter_provider/common/manager/font_manager.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    this.isLimitedLine = true,
  });

  final String hintText;
  final TextEditingController textEditingController;
  final bool isLimitedLine;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: FontFamilyConstants.fontFamily,
          fontSize: 18,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      style: const TextStyle(
        fontFamily: FontFamilyConstants.fontFamily,
        fontSize: 18,
      ),
      maxLines: isLimitedLine ? 1 : null,
    );
  }
}
