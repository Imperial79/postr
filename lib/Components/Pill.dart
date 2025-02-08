import 'package:flutter/material.dart';

import 'package:postr/Components/kCard.dart';

import '../Resources/colors.dart';

class Pill {
  Widget? child;
  String label;
  Color backgroundColor;
  Color? textColor;
  double fontSize;

  Pill({
    this.child,
    this.label = "text",
    this.backgroundColor = Kolor.primary,
    this.textColor = Colors.white,
    this.fontSize = 14.0, // Default font size
  });

  Widget get regular => KCard(
        child: child,
      );

  Widget get text => KCard(
        radius: 100,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        color: backgroundColor,
        child: Text(
          label,
          style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontVariations: const [FontVariation.weight(500)]),
        ),
      );
}
