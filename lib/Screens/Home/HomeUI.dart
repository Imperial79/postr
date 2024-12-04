import 'package:flutter/material.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Transform.rotate(
                    angle: .2,
                    child: const Icon(
                      Icons.adb_rounded,
                      color: Dark.primary,
                      size: 30,
                    ),
                  ),
                  width10,
                  const Text(
                    "Postr",
                    style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontVariations: [FontVariation.weight(500)],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      size: 30,
                    ),
                  ),
                ],
              ),
              height20,
              const Text("Welcome back, Avishek"),
              const Row(
                children: [
                  Flexible(
                    child: Text(
                      "Netaji Colony, Durgapur",
                      style: TextStyle(
                          fontSize: 20,
                          height: 1,
                          fontVariations: [FontVariation.weight(500)]),
                    ),
                  ),
                  width10,
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Dark.primary,
                    size: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
