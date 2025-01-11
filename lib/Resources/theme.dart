import 'package:flutter/material.dart';
import 'package:postr/Resources/colors.dart';

const String kFont = "Kumbh";

ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
  scaffoldBackgroundColor: Dark.scaffold,
  splashFactory: InkSplash.splashFactory,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Dark.primary,
  ).copyWith(brightness: Brightness.dark, surface: Dark.scaffold),
  textTheme: Typography().white.apply(fontFamily: kFont),
  iconTheme: const IconThemeData(color: Colors.white),
  appBarTheme: const AppBarTheme(
    backgroundColor: Dark.scaffold,
    foregroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
  ),
);
