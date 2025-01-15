import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Animations/FadeUp.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Resources/commons.dart';
import '../../Components/KScaffold.dart';
import '../../Components/kButton.dart';
import '../../Resources/colors.dart';
import '../../Resources/constants.dart';

class Confirmation_UI extends StatefulWidget {
  final String awbNumber;
  const Confirmation_UI({super.key, required this.awbNumber});

  @override
  State<Confirmation_UI> createState() => _Confirmation_UIState();
}

class _Confirmation_UIState extends State<Confirmation_UI> {
  @override
  Widget build(BuildContext context) {
    return KScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: FadeUpAnimate(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Transform.rotate(
                      angle: .2,
                      child: const Icon(
                        Icons.adb_rounded,
                        color: DColor.primary,
                        size: 50,
                      ),
                    ),
                    const Text(
                      "Postr",
                      style: TextStyle(
                        fontSize: 50,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontVariations: [FontVariation.weight(500)],
                      ),
                    ),
                  ],
                ),
                kHeight(50),
                const Icon(
                  Icons.inventory,
                  color: Colors.grey,
                  size: 100,
                ),
                kHeight(50),
                Label("Total estimated amount",
                        fontSize: 30,
                        fontWeight: 200,
                        textAlign: TextAlign.center)
                    .title,
                Label(
                  "Tracking ID",
                  fontSize: 20,
                  fontWeight: 500,
                  textAlign: TextAlign.center,
                ).regular,
                Label(
                  widget.awbNumber,
                  fontSize: 30,
                  fontWeight: 700,
                  color: DColor.primary,
                  textAlign: TextAlign.center,
                ).title,
                height20,
                Label("This amount is estimated and can vary if location or weight is changed.",
                        fontSize: 18, textAlign: TextAlign.center)
                    .subtitle,
                kHeight(50),
                KButton(
                  onPressed: () {
                    context.pop();
                  },
                  backgroundColor: kColor(context).primary,
                  label: "Back to Home",
                  style: KButtonStyle.expanded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
