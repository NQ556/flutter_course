import 'dart:ui';

class ColorManager {
  static Color primary = HexColor.fromHex("#7CA1B1");
  static Color background = HexColor.fromHex("#FCF0CC");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
