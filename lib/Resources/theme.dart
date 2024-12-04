import 'package:flutter/material.dart';
import 'package:postr/Resources/colors.dart';

const String kFont = "Kumbh";

// ThemeData darkTheme = ThemeData.dark(
//   useMaterial3: true,
// ).copyWith(
//   colorScheme: ColorScheme.fromSeed(seedColor: Dark.primary),
//   primaryTextTheme: const TextTheme(
//     bodyLarge: TextStyle(fontFamily: kFont, color: Colors.white),
//     bodyMedium: TextStyle(fontFamily: kFont, color: Colors.white),
//     bodySmall: TextStyle(fontFamily: kFont, color: Colors.white),
//     displayLarge: TextStyle(fontFamily: kFont, color: Colors.white),
//     displayMedium: TextStyle(fontFamily: kFont, color: Colors.white),
//     displaySmall: TextStyle(fontFamily: kFont, color: Colors.white),
//     headlineLarge: TextStyle(fontFamily: kFont, color: Colors.white),
//     headlineMedium: TextStyle(fontFamily: kFont, color: Colors.white),
//     headlineSmall: TextStyle(fontFamily: kFont, color: Colors.white),
//     labelLarge: TextStyle(fontFamily: kFont, color: Colors.white),
//     labelMedium: TextStyle(fontFamily: kFont, color: Colors.white),
//     labelSmall: TextStyle(fontFamily: kFont, color: Colors.white),
//     titleLarge: TextStyle(fontFamily: kFont, color: Colors.white),
//     titleMedium: TextStyle(fontFamily: kFont, color: Colors.white),
//     titleSmall: TextStyle(fontFamily: kFont, color: Colors.white),
//   ),
// );

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Dark.scaffold,
  colorScheme: ColorScheme.fromSeed(seedColor: Dark.primary)
      .copyWith(brightness: Brightness.dark),
  textTheme: Typography().white.apply(fontFamily: kFont),
  iconTheme: const IconThemeData(color: Colors.white),
);
