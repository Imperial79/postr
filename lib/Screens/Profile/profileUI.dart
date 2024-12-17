import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';

class ProfileUI extends ConsumerStatefulWidget {
  const ProfileUI({super.key});

  @override
  ConsumerState<ProfileUI> createState() => _ProfileUIState();
}

class _ProfileUIState extends ConsumerState<ProfileUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPadding).copyWith(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        NetworkImage("https://picsum.photos/200/300"),
                  ),
                  width20,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Label(
                        "Avishek Verma",
                        fontSize: 25,
                        fontWeight: 500,
                      ).regular,
                      Label(
                        "ID: 26137861723",
                        fontSize: 17,
                        fontWeight: 400,
                      ).subtitle,
                    ],
                  ),
                ],
              ),
              height20,
              Row(
                children: [
                  Expanded(
                    child: KCard(
                      padding: const EdgeInsets.all(20),
                      radius: 100,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.qr_code_scanner_outlined),
                          width20,
                          Flexible(
                              child: Label(
                            "New Track",
                            fontSize: 17,
                            fontWeight: 500,
                          ).regular),
                        ],
                      ),
                    ),
                  ),
                  width10,
                  Expanded(
                    child: KCard(
                      padding: const EdgeInsets.all(20),
                      radius: 100,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.support_agent),
                          width20,
                          Flexible(
                              child: Label(
                            "Contact Us",
                            fontSize: 17,
                            fontWeight: 500,
                          ).regular),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              height20,
            ],
          ),
        ),
      ),
    );
  }
}
