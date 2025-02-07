import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Components/Label.dart';
import 'colors.dart';

const SizedBox width5 = SizedBox(width: 5);
const SizedBox width10 = SizedBox(width: 10);
const SizedBox width20 = SizedBox(width: 20);
const SizedBox height5 = SizedBox(height: 5);
const SizedBox height10 = SizedBox(height: 10);
const SizedBox height20 = SizedBox(height: 20);
SizedBox kHeight(double height) => SizedBox(height: height);
SizedBox kWidth(double width) => SizedBox(width: width);

Widget get div => const Divider(
      color: Kolor.border,
      thickness: .5,
    );

systemColors() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}

BorderRadius kRadius(double radius) => BorderRadius.circular(radius);

Future<T?> navPush<T extends Object?>(BuildContext context, Widget screen) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

Future<T?> navPushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context, Widget screen) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screen));
}

Future<T?> navPopUntilPush<T extends Object?>(
    BuildContext context, Widget screen) {
  Navigator.popUntil(context, (route) => false);
  return navPush(context, screen);
}

KSnackbar(context, {required String message, bool error = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: error
          ? kColor(context).errorContainer
          : kColor(context).primaryContainer,
      content: Label(message,
              color: error
                  ? kColor(context).onErrorContainer
                  : kColor(context).onPrimaryContainer)
          .regular,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
    ),
  );
}

KErrorAlert(context, {required dynamic message}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Kolor.card,
      title: Label("An Error Occurred!", color: StatusText.danger).title,
      icon: const Icon(
        Icons.dangerous,
        color: StatusText.danger,
        size: 50,
      ),
      content: Label("$message").regular,
    ),
  );
}

Widget get kLoading => const Center(
      child: SizedBox(width: 100, child: LinearProgressIndicator()),
    );

Widget get kEmpty => Center(
      child: Column(
        children: [
          const Icon(
            Icons.inbox,
            color: Kolor.fadeText,
          ),
          Label(
            "Sorry!",
            color: Kolor.fadeText,
          ).title,
          Label(
            "No data found.",
            color: Kolor.fadeText,
          ).subtitle,
        ],
      ),
    );
Widget get kNodata => Center(
      child: Column(
        children: [
          const Icon(
            Icons.not_interested_sharp,
            color: Kolor.fadeText,
          ),
          Label(
            "Sorry!",
            color: Kolor.fadeText,
          ).title,
          Label(
            "No data found.",
            color: Kolor.fadeText,
          ).subtitle,
        ],
      ),
    );
