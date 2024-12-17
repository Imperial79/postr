import 'package:flutter/material.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/kButton.dart';
import 'package:postr/Resources/constants.dart';

import '../../Resources/colors.dart';
import '../../Resources/commons.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.rotate(
                          angle: .2,
                          child: const Icon(
                            Icons.adb_rounded,
                            color: Dark.primary,
                            size: 50,
                          ),
                        ),
                        width10,
                        Label(
                          "Postr",
                          fontSize: 50,
                          fontStyle: FontStyle.italic,
                          fontWeight: 800,
                        ).title,
                      ],
                    ),
                    height20,
                    Label(
                      "Fastest and most trusted package delivery",
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ).subtitle,
                  ],
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  const Icon(
                    Icons.security,
                    size: 16,
                  ),
                  Expanded(
                      child:
                          Label("Secure sign in with google", fontWeight: 400)
                              .regular)
                ],
              ),
              height10,
              KButton(
                      onPressed: () {},
                      label: "Sign in with Google",
                      backgroundColor: Dark.card,
                      icon: Image.asset(
                        "$kImagePath/google-logo.png",
                        height: 20,
                      ),
                      fontSize: 20,
                      padding: const EdgeInsets.all(20))
                  .withIcon,
            ],
          ),
        ),
      ),
    );
  }
}
