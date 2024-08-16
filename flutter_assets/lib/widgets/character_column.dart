import 'package:flutter/material.dart';

class CharacterColumn extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const CharacterColumn({
    super.key,
    required this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: text
          .split('')
          .map((char) => Text(
                char,
                style: textStyle,
              ))
          .toList(),
    );
  }
}
