import 'package:flutter/material.dart';

class DColor {
  static const Color scaffold = Color(0XFF141414);
  static const Color primary = Color(0XFF16b15e);
  static const Color card = Color(0XFF1d1d1d);
  static const Color border = Color(0xFF474747);
  static const Color fadeText = Color(0xFF9C9C9C);
}

class StatusText {
  static const Color danger =
      Color.fromARGB(255, 255, 165, 165); // Added a color for danger status
  static const Color success = Color.fromARGB(255, 101, 255, 137);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF17a2b8);
  static const Color light = Color(0xFFf8f9fa);
  static const Color dark = Color(0xFF343a40);
}

Color kOpacity(Color color, double opacity) =>
    color.withAlpha((opacity * 255).round());

ColorScheme kColor(BuildContext context) => Theme.of(context).colorScheme;

ColorFilter kSvgColor(Color color) => ColorFilter.mode(color, BlendMode.srcIn);
