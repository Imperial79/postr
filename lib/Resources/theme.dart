import 'package:flutter/material.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';

const String kFont = "Kumbh";

ColorScheme get kScheme => ColorScheme.fromSeed(
      seedColor: Kolor.primary,
      brightness: Brightness.dark,
      surface: Kolor.scaffold,
      onSurface: Kolor.text,
    );

ThemeData darkTheme(context) => ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: Kolor.scaffold,
      splashFactory: InkSplash.splashFactory,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Kolor.primary,
      ).copyWith(
        brightness: Brightness.dark,
        onSurface: Kolor.text,
        surface: Kolor.card,
      ),
      dialogBackgroundColor: Kolor.card,
      textTheme: Typography().white.apply(fontFamily: kFont),
      iconTheme: const IconThemeData(color: Kolor.text),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Kolor.primary)),
      appBarTheme: const AppBarTheme(
        backgroundColor: Kolor.scaffold,
        foregroundColor: Kolor.text,
        elevation: 0,
        iconTheme: IconThemeData(color: Kolor.text),
      ),
      chipTheme: ChipThemeData(
        selectedColor: kColor(context).secondary,
        labelStyle: const TextStyle(
          color: Kolor.text,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: Kolor.primary,
        cursorColor: Kolor.primary,
        selectionColor: kColor(context).tertiary,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Kolor.primary,
        linearTrackColor: Kolor.card,
        circularTrackColor: Kolor.card,
        refreshBackgroundColor: Kolor.card,
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: const WidgetStatePropertyAll(Kolor.border),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: kRadius(10))),
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: const WidgetStatePropertyAll(Kolor.border),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: kRadius(10))),
        ),
      ),
    );
