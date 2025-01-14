import 'package:flutter/material.dart';
import 'package:postr/Resources/colors.dart';

const String kFont = "Kumbh";

ThemeData darkTheme(context) => ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: DColor.scaffold,
      splashFactory: InkSplash.splashFactory,
      colorScheme: ColorScheme.fromSeed(
        seedColor: DColor.primary,
      ).copyWith(brightness: Brightness.dark, surface: DColor.scaffold),
      textTheme: Typography().white.apply(fontFamily: kFont),
      iconTheme: const IconThemeData(color: Colors.white),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: DColor.primary)),
      appBarTheme: const AppBarTheme(
        backgroundColor: DColor.scaffold,
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
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: DColor.primary,
        linearTrackColor: DColor.card,
        circularTrackColor: DColor.card,
        refreshBackgroundColor: DColor.card,
      ),
    );
