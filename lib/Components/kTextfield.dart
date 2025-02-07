import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/theme.dart';
import '../Resources/commons.dart';
import 'Label.dart';
import 'kButton.dart';

class KValidation {
  static String? required(String? val) =>
      val == null || val.isEmpty ? 'Required!' : null;

  static String? phone(String? val) {
    if (val == null || val.isEmpty) return 'Required!';
    return val.length != 10 ? "Phone must be of length 10!" : null;
  }

  static String? email(String? val) {
    if (val == null || val.isEmpty) return 'Required!';
    String pattern = r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    return !RegExp(pattern).hasMatch(val)
        ? 'Enter a valid email address'
        : null;
  }

  static String? pan(String? val) {
    if (val == null || val.isEmpty) return 'Required!';
    return val.length != 10 ? 'Length must be 10!' : null;
  }
}

class KTextfield {
  static const double kFontSize = 17;
  static const double kTextHeight = 1.5;

  /// Show Required text aside Label.
  final bool showRequired;
  final bool autoFocus;
  final void Function()? onTap;
  final bool? readOnly;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? prefixText;
  final Widget? prefix;
  final Widget? suffix;
  final Color? cursorColor;
  final Color? fieldColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintTextColor;
  final bool? obscureText;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final FocusNode? focusNode;
  final String? label;
  final double? fontSize;
  final Widget? labelIcon;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String val)? onChanged;
  final String? Function(String? val)? validator;
  final void Function(String val)? onFieldSubmitted;
  final Iterable<String>? autofillHints;

  KTextfield({
    this.showRequired = true,
    this.autoFocus = false,
    this.onTap,
    this.readOnly,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.prefixText,
    this.prefix,
    this.suffix,
    this.fieldColor = Kolor.scaffold,
    this.cursorColor = Kolor.primary,
    this.borderColor,
    this.textColor,
    this.hintTextColor,
    this.obscureText,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.focusNode,
    this.label,
    this.fontSize = kFontSize,
    this.labelIcon,
    this.textCapitalization = TextCapitalization.words,
    this.inputFormatters,
    this.onChanged,
    this.validator,
    this.onFieldSubmitted,
    this.autofillHints,
  });

  static const TextStyle kTextstyle = TextStyle(
    fontVariations: [FontVariation.weight(500)],
    fontSize: kFontSize,
    letterSpacing: .5,
    height: kTextHeight,
    fontFamily: kFont,
  );

  static const TextStyle kHintStyle = TextStyle(
    fontVariations: [FontVariation.weight(400)],
    fontSize: kFontSize,
    height: kTextHeight,
    color: Kolor.fadeText,
    fontFamily: kFont,
  );

  Widget get kLabel => Label(
        label!,
        weight: 400,
        fontSize: 15,
      ).regular;

  InputBorder borderStyle(Color? customBorder) => OutlineInputBorder(
        borderRadius: kRadius(10),
        borderSide:
            BorderSide(color: borderColor ?? customBorder ?? Kolor.border),
      );

  Widget get regular => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 7.0),
              child: Row(
                children: [
                  if (labelIcon != null) labelIcon!,
                  kLabel,
                  if (validator != null && showRequired)
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Label(
                        "(Required)",
                        color: StatusText.danger,
                        fontSize: 10,
                        height: 1,
                      ).regular,
                    ),
                ],
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              if (prefixText != null)
                KCard(
                  padding: const EdgeInsets.all(12),
                  color: Kolor.scaffold,
                  radius: 10,
                  borderColor: Kolor.border,
                  borderWidth: 1,
                  child: Label(prefixText ?? "",
                          height: kTextHeight, fontSize: fontSize)
                      .regular,
                ),
              Flexible(
                child: TextFormField(
                  autofocus: autoFocus,
                  onTap: onTap,
                  focusNode: focusNode,
                  autofillHints: autofillHints,
                  controller: controller,
                  textCapitalization: textCapitalization,
                  style:
                      kTextstyle.copyWith(fontSize: fontSize, color: textColor),
                  cursorColor: cursorColor,
                  readOnly: readOnly ?? false,
                  obscureText: obscureText ?? false,
                  keyboardType: keyboardType,
                  maxLength: maxLength,
                  maxLines: maxLines,
                  minLines: minLines,
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fieldColor ?? Kolor.text,
                    counterText: '',
                    prefixIconConstraints:
                        const BoxConstraints(minHeight: 0, minWidth: 0),
                    suffixIconConstraints:
                        const BoxConstraints(minHeight: 0, minWidth: 0),
                    prefixIcon: prefix != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 12, right: 10),
                            child: prefix!,
                          )
                        : const SizedBox(width: 12),
                    suffixIcon: suffix != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 5, right: 12),
                            child: suffix!,
                          )
                        : const SizedBox(width: 12),
                    isDense: true,
                    border: borderStyle(null),
                    errorBorder: borderStyle(StatusText.danger),
                    focusedBorder: borderStyle(Kolor.border),
                    enabledBorder: borderStyle(null),
                    errorStyle: const TextStyle(color: StatusText.danger),
                    hintText: hintText,
                    hintStyle: kHintStyle.copyWith(
                        fontSize: fontSize, color: hintTextColor),
                  ),
                  onChanged: onChanged,
                  validator: validator,
                  onFieldSubmitted: onFieldSubmitted,
                ),
              ),
            ],
          ),
        ],
      );

  Widget get otp => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 7.0),
              child: Row(
                children: [
                  if (labelIcon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: labelIcon,
                    ),
                  kLabel
                ],
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (prefixText != null && prefix == null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Kolor.primary,
                    borderRadius: kRadius(10),
                  ),
                  child: Label(
                    prefixText!,
                    fontSize: fontSize,
                    color: textColor,
                    textAlign: TextAlign.center,
                  ).regular,
                )
              else if (prefixText == null && prefix != null)
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Kolor.primary,
                    borderRadius: kRadius(10),
                  ),
                  child: prefix!,
                ),
              Flexible(
                child: TextFormField(
                  controller: controller,
                  textCapitalization: textCapitalization,
                  style:
                      kTextstyle.copyWith(fontSize: fontSize, color: textColor),
                  textAlign: TextAlign.center,
                  readOnly: readOnly ?? false,
                  obscureText: obscureText ?? false,
                  keyboardType: keyboardType,
                  maxLength: maxLength,
                  maxLines: maxLines,
                  minLines: maxLines,
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Kolor.card,
                    counterText: '',
                    isDense: true,
                    border: borderStyle(null),
                    errorBorder: borderStyle(StatusText.danger),
                    focusedBorder: borderStyle(Kolor.border),
                    enabledBorder: borderStyle(null),
                    hintText: hintText,
                    hintStyle: kHintStyle.copyWith(
                        fontSize: fontSize, color: hintTextColor),
                  ),
                  onChanged: onChanged,
                  validator: validator,
                ),
              ),
              const SizedBox(width: 10),
              KButton(onPressed: onTap, label: 'Send OTP'),
            ],
          ),
        ],
      );

  Widget dropdown({
    required List<DropdownMenuItem<String>>? items,
    required void Function(String? val)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 7.0),
            child: Row(
              children: [
                if (labelIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 7.0),
                    child: labelIcon,
                  ),
                kLabel,
                if (validator != null && showRequired)
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Label(
                      "(Required)",
                      weight: 600,
                      color: StatusText.danger,
                      fontSize: 10,
                    ).regular,
                  ),
              ],
            ),
          ),
        DropdownButtonFormField<String>(
          value: controller.text,
          hint: Text(
            hintText ?? "Choose an Option",
            style:
                kHintStyle.copyWith(fontSize: fontSize, color: hintTextColor),
          ),
          onChanged: onChanged,
          isDense: true,
          menuMaxHeight: 300,
          dropdownColor: Kolor.border,
          elevation: 0,
          style: kTextstyle.copyWith(
              fontSize: fontSize, color: textColor ?? Kolor.text),
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          decoration: InputDecoration(
            errorStyle: const TextStyle(color: StatusText.danger),
            border: borderStyle(null),
            errorBorder: borderStyle(StatusText.danger),
            focusedBorder: borderStyle(Kolor.border),
            enabledBorder: borderStyle(null),
            filled: true,
            fillColor: fieldColor,
            hintStyle:
                kHintStyle.copyWith(fontSize: fontSize, color: hintTextColor),
          ),
          validator: (value) => value!.isEmpty ? "Required!" : null,
          items: items,
        ),
      ],
    );
  }

  // Widget dropdown({
  //   required List<DropdownMenuEntry<dynamic>> dropdownMenuEntries,
  //   void Function(dynamic)? onSelected,
  //   Widget? leadingIcon,
  //   String? errorText,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       if (label != null)
  //         Padding(
  //           padding: const EdgeInsets.only(bottom: 7.0),
  //           child: Row(
  //             children: [
  //               if (labelIcon != null)
  //                 Padding(
  //                   padding: const EdgeInsets.only(right: 7.0),
  //                   child: labelIcon,
  //                 ),
  //               kLabel,
  //               if (validator != null && showRequired)
  //                 const Padding(
  //                   padding: EdgeInsets.only(left: 3.0),
  //                   child: Text(
  //                     "(Required)",
  //                     style: TextStyle(
  //                         weight: FontWeight.w500,
  //                         color: StatusText.danger,
  //                         fontSize: 10,
  //                         height: 1),
  //                   ),
  //                 ),
  //             ],
  //           ),
  //         ),
  //       DropdownMenu(
  //         controller: controller,
  //         hintText: hintText,
  //         errorText: errorText,
  //         textStyle:
  //             kFieldTextstyle.copyWith(fontSize: fontSize, color: textColor),
  //         onSelected: onSelected,
  //         expandedInsets: EdgeInsets.zero,
  //         menuStyle: const MenuStyle(
  //             backgroundColor: WidgetStatePropertyAll(Kolor.card)),
  //         inputDecorationTheme: InputDecorationTheme(
  //           errorStyle: const TextStyle(color: StatusText.danger),
  //           activeIndicatorBorder: const BorderSide(color: Kolor.border),
  //           border: borderStyle(null),
  //           errorBorder: borderStyle(StatusText.danger),
  //           focusedBorder: borderStyle(Kolor.border),
  //           enabledBorder: borderStyle(null),
  //           filled: true,
  //           fillColor: fieldColor,
  //           hintStyle: kHintTextstyle.copyWith(
  //               fontSize: fontSize, color: hintTextColor),
  //         ),
  //         selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_rounded),
  //         trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
  //         leadingIcon: leadingIcon,
  //         dropdownMenuEntries: dropdownMenuEntries,
  //         menuHeight: 300,
  //       ),
  //     ],
  //   );
  // }
}
