import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Animations/FadeUp.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Resources/commons.dart';
import '../../Components/KScaffold.dart';
import '../../Components/kButton.dart';
import '../../Resources/colors.dart';
import '../../Resources/constants.dart';

class CalculatedResultUI extends StatefulWidget {
  final double amount;
  const CalculatedResultUI({super.key, required this.amount});

  @override
  State<CalculatedResultUI> createState() => _CalculatedResultUIState();
}

class _CalculatedResultUIState extends State<CalculatedResultUI> {
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
                        color: Kolor.primary,
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
                TweenAnimationBuilder<double>(
                  duration: const Duration(seconds: 1),
                  tween: Tween<double>(
                      begin: widget.amount / 2, end: widget.amount),
                  builder: (context, value, child) {
                    return Row(
                      spacing: 5,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Label(
                          "₹ ${value.toStringAsFixed(2)}",
                          fontSize: 30,
                          fontWeight: 700,
                          color: Kolor.primary,
                          textAlign: TextAlign.center,
                        ).title,
                        Label("INR", fontSize: 20, fontWeight: 200).regular,
                      ],
                    );
                  },
                ),
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
