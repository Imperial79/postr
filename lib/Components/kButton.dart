import 'package:flutter/material.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Resources/theme.dart';
import '../Resources/colors.dart';
import '../Resources/commons.dart';

class KButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double fontSize;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle? customStyle;
  final bool isLoading;
  final VisualDensity? visualDensity;
  final KButtonStyle style;
  final double weight;

  const KButton({
    super.key,
    this.weight = 600,
    required this.onPressed,
    this.label = "",
    this.backgroundColor,
    this.foregroundColor = Colors.white,
    this.fontSize = 15,
    this.icon,
    this.padding,
    this.customStyle,
    this.isLoading = false,
    this.visualDensity,
    this.style = KButtonStyle.regular,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: !isLoading ? onPressed : null,
      style: customStyle ?? _buttonStyle(context),
      child: _buildChild(),
    );
  }

  ButtonStyle _buttonStyle(BuildContext context) {
    final commonStyle = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? kColor(context).primary,
      foregroundColor: foregroundColor ?? kColor(context).onPrimary,
      iconColor: foregroundColor,
      padding: padding ?? const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: kRadius(15),
      ),
      visualDensity: visualDensity,
      elevation: 0,
      shadowColor: Colors.transparent,
      disabledBackgroundColor: Kolor.card,
      alignment: Alignment.center,
      textStyle: TextStyle(
        fontSize: fontSize,
        fontVariations: [FontVariation.weight(weight)],
        fontFamily: kFont,
      ),
    );

    switch (style) {
      case KButtonStyle.outlined:
        return commonStyle.copyWith(
          side: WidgetStateProperty.all(
            BorderSide(
                color: borderColor ??
                    foregroundColor ??
                    kColor(context).primaryContainer),
          ),
          backgroundColor: WidgetStateProperty.all(
              backgroundColor ?? kColor(context).surface),
          foregroundColor: WidgetStateProperty.all(
              foregroundColor ?? kColor(context).primaryContainer),
          textStyle: WidgetStateProperty.all(
            TextStyle(
              fontSize: fontSize,
              fontVariations: const [FontVariation.weight(700)],
              fontFamily: kFont,
            ),
          ),
        );
      case KButtonStyle.pill:
        return TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(15),
          ),
          backgroundColor: backgroundColor ?? kColor(context).primary,
          foregroundColor: foregroundColor ?? kColor(context).onPrimary,
          iconColor: foregroundColor,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 15),
        );
      case KButtonStyle.thickPill:
        return commonStyle.copyWith(
          padding: WidgetStateProperty.all(padding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 17)),
          textStyle: WidgetStateProperty.all(
            TextStyle(
              fontSize: fontSize,
              fontVariations: const [FontVariation.weight(500)],
              fontFamily: kFont,
            ),
          ),
        );
      case KButtonStyle.regular:
        return commonStyle;
      case KButtonStyle.expanded:
        return commonStyle.copyWith(
          minimumSize: WidgetStateProperty.all(const Size.fromHeight(50)),
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
            Label(label, fontWeight: 500).regular,
            if (icon != null) ...[
              const Spacer(),
              icon!,
            ]
          ],
        );
      case KButtonStyle.pill:
      case KButtonStyle.thickPill:
        return Row(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) icon!,
            Text(
              label,
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        );
      case KButtonStyle.regular:
      case KButtonStyle.expanded:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
            ),
            if (icon != null) ...[const Spacer(), icon!],
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
              color: Kolor.primary,
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "Loading...",
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color: Colors.white,
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
