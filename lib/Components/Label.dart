import 'package:flutter/material.dart';

import '../Resources/colors.dart';
import '../Resources/commons.dart';

class Label {
  final String text;
  final Color? color;
  final double? fontSize;
  final double? fontWeight;
  final int? maxLines;
  final FontStyle? fontStyle;

  Label(
    this.text, {
    this.color,
    this.fontSize,
    this.fontWeight,
    this.maxLines,
    this.fontStyle,
  });

  Widget get title => Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 20,
          color: color,
          fontVariations: [FontVariation.weight(fontWeight ?? 500)],
          fontStyle: fontStyle,
        ),
        maxLines: maxLines,
        overflow: maxLines != null ? TextOverflow.ellipsis : null,
      );
  Widget get subtitle => Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 14,
          color: color ?? Dark.fadeText,
          fontVariations: [FontVariation.weight(fontWeight ?? 400)],
          fontStyle: fontStyle,
        ),
        maxLines: maxLines,
        overflow: maxLines != null ? TextOverflow.ellipsis : null,
      );

  Widget get spread => Center(
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            letterSpacing: 3,
            wordSpacing: 5,
            fontVariations: [FontVariation.weight(fontWeight ?? 600)],
            fontSize: 14,
            fontStyle: fontStyle,
            color: color ?? Colors.grey.shade600,
          ),
        ),
      );

  Widget get regular => Text(
        text,
        style: TextStyle(
          fontVariations: [FontVariation.weight(fontWeight ?? 600)],
          color: color,
          fontSize: fontSize,
          fontStyle: fontStyle,
        ),
      );
  Widget get withDivider => Row(
        children: [
          Text(
            text.toUpperCase(),
            style: TextStyle(
              letterSpacing: .7,
              fontSize: fontSize,
              color: color,
              fontStyle: fontStyle,
              fontVariations: [FontVariation.weight(fontWeight ?? 500)],
            ),
          ),
          width5,
          const Expanded(child: Divider())
        ],
      );
}
