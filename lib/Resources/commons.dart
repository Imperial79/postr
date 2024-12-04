import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const SizedBox width5 = SizedBox(width: 5);
const SizedBox width10 = SizedBox(width: 10);
const SizedBox width20 = SizedBox(width: 20);
const SizedBox height5 = SizedBox(height: 5);
const SizedBox height10 = SizedBox(height: 10);
const SizedBox height20 = SizedBox(height: 20);
SizedBox kHeight(double height) => SizedBox(height: height);
SizedBox kWidth(double width) => SizedBox(width: width);

systemColors() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}
