import 'package:flutter/material.dart';
import 'package:postr/Resources/theme.dart';
import '../Resources/colors.dart';
import '../Resources/commons.dart';

class KButton extends StatelessWidget {
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
  final KButtonStyle style;

  const KButton({
    super.key,
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
    this.style = KButtonStyle.regular,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: !isLoading ? onPressed : null,
      style: customStyle ?? _buttonStyle(),
      child: _buildChild(),
    );
  }

  ButtonStyle _buttonStyle() {
    switch (style) {
      case KButtonStyle.outlined:
        return ElevatedButton.styleFrom(
          side: BorderSide(color: foregroundColor ?? Dark.primary),
          backgroundColor: backgroundColor ?? Colors.transparent,
          foregroundColor: foregroundColor ?? Colors.white,
          iconColor: foregroundColor,
          padding: padding ?? const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(100),
          ),
          visualDensity: visualDensity,
          elevation: 0,
          shadowColor: Colors.transparent,
          alignment: Alignment.center,
          textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            fontFamily: kFont,
          ),
        );
      case KButtonStyle.pill:
        return TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(100),
          ),
          backgroundColor: backgroundColor ?? Dark.primary,
          foregroundColor: foregroundColor ?? Colors.white,
          iconColor: foregroundColor,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 15),
        );
      case KButtonStyle.thickPill:
        return ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Dark.primary,
          foregroundColor: foregroundColor ?? Colors.white,
          iconColor: foregroundColor,
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(100),
          ),
          visualDensity: visualDensity,
          elevation: 0,
          shadowColor: Colors.transparent,
          alignment: Alignment.center,
          textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            fontFamily: kFont,
          ),
        );
      case KButtonStyle.regular:
        return ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          iconColor: foregroundColor,
          padding: padding ?? const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(100),
          ),
          visualDensity: visualDensity,
          elevation: 0,
          shadowColor: Colors.transparent,
          alignment: Alignment.center,
          textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            fontFamily: kFont,
          ),
        );
      case KButtonStyle.expanded:
        return ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          iconColor: foregroundColor,
          padding: padding ?? const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(100),
          ),
          visualDensity: visualDensity,
          elevation: 0,
          shadowColor: Colors.transparent,
          alignment: Alignment.center,
          textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            fontFamily: kFont,
          ),
          minimumSize: const Size.fromHeight(50), // Full width
        );
    }
  }

  Widget _buildChild() {
    if (isLoading) {
      return _loadingIndicator();
    }

    switch (style) {
      case KButtonStyle.outlined:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
            ),
            if (icon != null) ...[
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: icon,
              ),
            ]
          ],
        );
      case KButtonStyle.pill:
      case KButtonStyle.thickPill:
        return Row(
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
        );
      case KButtonStyle.regular:
      case KButtonStyle.expanded:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
            ),
            if (icon != null) icon!,
          ],
        );
    }
  }

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

enum KButtonStyle {
  regular,
  outlined,
  pill,
  thickPill,
  expanded,
}
