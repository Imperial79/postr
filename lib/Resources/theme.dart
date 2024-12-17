import 'package:flutter/material.dart';
import 'package:postr/Resources/colors.dart';

const String kFont = "Kumbh";

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Dark.scaffold,
  colorScheme: ColorScheme.fromSeed(seedColor: Dark.primary)
      .copyWith(brightness: Brightness.dark),
  textTheme: Typography().white.apply(fontFamily: kFont),
  fontFamily: kFont,
  iconTheme: const IconThemeData(color: Colors.white),
);
