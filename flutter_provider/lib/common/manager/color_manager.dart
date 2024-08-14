import 'dart:ui';

class ColorManager {
  static Color color_1 = HexColor.fromHex("#DEC3D1");
  static Color color_2 = HexColor.fromHex("#C7E9E3");
  static Color color_3 = HexColor.fromHex("#C6D6EF");
  static Color color_4 = HexColor.fromHex("#F2D1DA");
  static Color color_5 = HexColor.fromHex("#BEB6DB");
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
