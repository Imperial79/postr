import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Animations/FadeUp.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Models/Courier_Model.dart';
import 'package:postr/Resources/commons.dart';
import '../../Components/KScaffold.dart';
import '../../Components/kButton.dart';
import '../../Resources/colors.dart';
import '../../Resources/constants.dart';

class Confirmation_UI extends StatefulWidget {
  final CourierModel masterdata;
  const Confirmation_UI({super.key, required this.masterdata});

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
                Label(
                  "Order No.",
                  fontSize: 20,
                  fontWeight: 500,
                  textAlign: TextAlign.center,
                ).regular,
                Label(
                  "#${widget.masterdata.txnId}",
                  fontSize: 30,
                  fontWeight: 700,
                  color: DColor.primary,
                  textAlign: TextAlign.center,
                ).title,
                height20,
                Label("You will be notiifed once a rider is available to pickup your package.",
                        fontSize: 18, textAlign: TextAlign.center)
                    .subtitle,
                height20,
                Label("THANK YOU FOR CHOOSING US",
                        fontSize: 18, textAlign: TextAlign.center)
                    .subtitle,
                kHeight(50),
                KButton(
                  onPressed: () {
                    context.pop();
                  },
                  backgroundColor: kColor(context).tertiary,
                  label: "Back to Home",
                  fontSize: 20,
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
