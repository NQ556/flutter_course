import 'package:flutter/material.dart';
import 'package:flutter_hive/common/manager/font_manager.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;

  const RoundedButton(
      {super.key,
      required this.buttonText,
      this.onTap,
      required this.backgroundColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: SizedBox(
        width: 200,
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontFamily: FontFamilyConstants.fontFamily,
              fontSize: 18,
              fontWeight: FontWeightManager.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
