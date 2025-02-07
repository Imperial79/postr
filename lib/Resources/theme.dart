import 'package:flutter/material.dart';
import 'package:postr/Resources/colors.dart';

const String kFont = "Kumbh";

ColorScheme get kScheme => ColorScheme.fromSeed(
      seedColor: Kolor.primary,
      brightness: Brightness.dark,
      surface: Kolor.scaffold,
      onSurface: Colors.white,
    );

ThemeData darkTheme(context) => ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: Kolor.scaffold,
      splashFactory: InkSplash.splashFactory,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Kolor.primary,
      ).copyWith(
        brightness: Brightness.dark,
        onSurface: Colors.white,
        surface: Kolor.card,
      ),
      dialogBackgroundColor: Kolor.card,
      textTheme: Typography().white.apply(fontFamily: kFont),
      iconTheme: const IconThemeData(color: Colors.white),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Kolor.primary)),
      appBarTheme: const AppBarTheme(
        backgroundColor: Kolor.scaffold,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      chipTheme: ChipThemeData(
        selectedColor: kColor(context).secondary,
        labelStyle: const TextStyle(
          color: Colors.white,
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
    );
