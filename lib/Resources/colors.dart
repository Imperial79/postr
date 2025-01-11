import 'package:flutter/material.dart';

class Dark {
  static const Color scaffold = Color(0XFF141414);
  static const Color primary = Color(0XFF16b15e);
  static const Color card = Color(0XFF1d1d1d);
  static const Color border = Color(0xFF757575);
  static const Color fadeText = Color(0xFF9C9C9C);
}

Color kOpacity(Color color, double opacity) =>
    color.withAlpha((opacity * 255).round());

ColorScheme kColor(BuildContext context) => Theme.of(context).colorScheme;

ColorFilter kSvgColor(Color color) => ColorFilter.mode(color, BlendMode.srcIn);
