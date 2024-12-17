import 'package:flutter/material.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Resources/theme.dart';

import '../Resources/colors.dart';
import '../Resources/commons.dart';

class KButton {
  final void Function()? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double fontSize;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle? customStyle;
  final bool isLoading;
  final VisualDensity? visualDensity;

  KButton({
    required this.onPressed,
    this.label = "",
    this.backgroundColor = Dark.primary,
    this.foregroundColor = Colors.white,
    this.fontSize = 15,
    this.icon,
    this.padding,
    this.customStyle,
    this.isLoading = false,
    this.visualDensity,
  });

  // Helper method for common button styles
  ButtonStyle _buttonStyle({
    Color? backgroundColor,
    Color? foregroundColor,
    BorderSide? side,
    EdgeInsetsGeometry? padding,
    double borderRadius = 12,
    double elevation = 0,
    VisualDensity? visualDensity,
  }) =>
      ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        side: side,
        padding: padding ?? this.padding ?? const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: kRadius(borderRadius),
        ),
        visualDensity: visualDensity,
        elevation: elevation,
        shadowColor: Colors.transparent,
        alignment: Alignment.center,
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          fontFamily: kFont,
        ),
      );

  // Full-width button
  Widget get full => ElevatedButton(
        onPressed: !isLoading ? onPressed : null,
        style: customStyle ??
            _buttonStyle(
                backgroundColor: backgroundColor ?? Dark.primary,
                foregroundColor: foregroundColor ?? Colors.white,
                visualDensity: visualDensity),
        child: SizedBox(
          width: double.infinity,
          child: !isLoading
              ? Text(
                  label,
                  textAlign: TextAlign.center,
                )
              : _loadingIndicator(),
        ),
      );

  // Outlined full-width button
  Widget get outlinedFull => ElevatedButton(
        onPressed: !isLoading ? onPressed : null,
        style: customStyle ??
            _buttonStyle(
              side: BorderSide(color: foregroundColor ?? Dark.primary),
              backgroundColor: backgroundColor ?? Colors.transparent,
              foregroundColor: foregroundColor ?? Dark.primary,
              elevation: 0,
            ),
        child: SizedBox(
          width: double.maxFinite,
          child: !isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                          fontSize: fontSize, fontWeight: FontWeight.w500),
                    ),
                    if (icon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: icon,
                      ),
                  ],
                )
              : _loadingIndicator(),
        ),
      );

  // Outlined regular button
  Widget get outlinedRegular => ElevatedButton(
        onPressed: !isLoading ? onPressed : null,
        style: customStyle ??
            _buttonStyle(
              side: BorderSide(color: backgroundColor ?? Dark.primary),
              backgroundColor: backgroundColor ?? Colors.transparent,
              foregroundColor: foregroundColor ?? Colors.black,
              padding: padding,
            ),
        child: !isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Padding(
                        padding: const EdgeInsets.only(right: 10), child: icon),
                  Text(
                    label,
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.w500),
                  ),
                ],
              )
            : _loadingIndicator(),
      );

  // Regular button
  Widget get regular => ElevatedButton(
        onPressed: !isLoading ? onPressed : null,
        style: customStyle ??
            _buttonStyle(
                backgroundColor: backgroundColor ?? Dark.primary,
                foregroundColor: foregroundColor ?? Colors.white,
                visualDensity: visualDensity),
        child: !isLoading
            ? Text(
                label,
                textAlign: TextAlign.center,
              )
            : _loadingIndicator(),
      );

  // Regular button
  Widget get small => ElevatedButton(
        onPressed: !isLoading ? onPressed : null,
        style: customStyle ??
            _buttonStyle(
                backgroundColor: backgroundColor ?? Dark.primary,
                foregroundColor: foregroundColor ?? Colors.white,
                visualDensity: VisualDensity.compact,
                borderRadius: 8),
        child: !isLoading
            ? Text(
                label,
                textAlign: TextAlign.center,
              )
            : _loadingIndicator(),
      );

  // Icon button
  Widget get withIcon => ElevatedButton(
        onPressed: !isLoading ? onPressed : null,
        style: customStyle ??
            _buttonStyle(
              backgroundColor: backgroundColor ?? Dark.primary,
              foregroundColor: foregroundColor ?? Colors.white,
            ),
        child: !isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (label.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Label(
                        label,
                      ).regular,
                    ),
                  icon ?? const SizedBox.shrink(),
                ],
              )
            : _loadingIndicator(),
      );

  // Pill button
  Widget get pill => TextButton(
        onPressed: !isLoading ? onPressed : null,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(100),
          ),
          backgroundColor: backgroundColor ?? Dark.primary,
          foregroundColor: foregroundColor ?? Colors.white,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 15),
        ),
        child: !isLoading
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: icon,
                    ),
                  Text(
                    label,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ],
              )
            : _loadingIndicator(),
      );

  // Thick pill button
  Widget get thickPill => ElevatedButton(
        onPressed: !isLoading ? onPressed : null,
        style: customStyle ??
            _buttonStyle(
              backgroundColor: backgroundColor ?? Dark.primary,
              foregroundColor: foregroundColor ?? Colors.white,
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
              borderRadius: 100,
            ),
        child: !isLoading
            ? Text(
                label,
                style: TextStyle(fontSize: fontSize),
              )
            : _loadingIndicator(),
      );

  Widget _loadingIndicator() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.black,
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "Loading...",
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      );
}
