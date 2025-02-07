import 'package:flutter/material.dart';
import 'package:postr/Resources/commons.dart';
import 'Label.dart';

Widget KHeading({
  required String title,
  required String subtitle,
  bool isLoading = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 70),
    child: Center(
      child: Column(
        children: [
          Label(title, fontSize: 25, weight: 650).title,
          Label(subtitle,
                  fontSize: 20, weight: 350, textAlign: TextAlign.center)
              .title,
          if (isLoading) ...[height10, kLoading]
        ],
      ),
    ),
  );
}
