import 'package:flutter/material.dart';
import 'package:postr/Resources/app_config.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';

class SplashUI extends StatelessWidget {
  const SplashUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.rotate(
                          angle: .2,
                          child: const Icon(
                            Icons.adb_rounded,
                            color: DColor.primary,
                            size: 50,
                          ),
                        ),
                        width10,
                        const Text(
                          "Postr",
                          style: TextStyle(
                            fontSize: 50,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontVariations: [FontVariation.weight(700)],
                          ),
                        ),
                      ],
                    ),
                    height20,
                    const Text(
                      "Fastest and most trusted package delivery",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const Text(
                "Version $kAppVersion",
                style: TextStyle(height: 10),
              ),
              // height20,
              const Text(
                "Made with ❤️ in India",
                style: TextStyle(fontSize: 15, height: 5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
