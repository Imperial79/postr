import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Components/KSearchbar.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/Pill.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Components/kCarousel.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';

import '../../Repository/Auth/auth_repo.dart';

class HomeUI extends ConsumerStatefulWidget {
  const HomeUI({super.key});

  @override
  ConsumerState<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends ConsumerState<HomeUI> {
  int activeStep = 2;
  final searchKey = TextEditingController();
  @override
  void dispose() {
    searchKey.dispose();
    super.dispose();
  }

  Future<void> _scan() async {
    try {
      final possibleFormats = BarcodeFormat.values.toList()
        ..removeWhere((e) => e == BarcodeFormat.unknown);
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          restrictFormat: possibleFormats,
          useCamera: 0,
          autoEnableFlash: false,
          android: const AndroidOptions(
            aspectTolerance: 0.00,
            useAutoFocus: true,
          ),
        ),
      );
      if (result.rawContent.isNotEmpty) {
        KSnackbar(
          context,
          message: result.rawContent,
        );
      }
    } on PlatformException catch (e) {
      KSnackbar(
        context,
        message: e.code == BarcodeScanner.cameraAccessDenied
            ? 'The user did not grant the camera permission!'
            : 'Unknown error: $e',
        error: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPadding).copyWith(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Transform.rotate(
                    angle: .2,
                    child: const Icon(
                      Icons.adb_rounded,
                      color: Kolor.primary,
                      size: 20,
                    ),
                  ),
                  width5,
                  const Text(
                    "Postr",
                    style: TextStyle(
                      fontSize: 20,
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
              Label("Welcome back, ${user.name.split(" ").first}").subtitle,
              Row(
                children: [
                  Flexible(
                    child: Label("Netaji Colony, Durgapur", fontSize: 18).title,
                  ),
                  width10,
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Kolor.primary,
                    size: 20,
                  ),
                ],
              ),
              height20,
              Row(
                children: [
                  // Expanded(
                  //   child: KCard(
                  //     height: 80,
                  //     radius: 10,
                  //     color: kColor(context).primary,
                  //     child: Column(
                  //       spacing: 5,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Label("My Balance").regular,
                  //         Row(
                  //           children: [
                  //             const Icon(Icons.account_balance_wallet),
                  //             width10,
                  //             Flexible(
                  //               child: Label("INR 1,000",
                  //                       maxLines: 1, fontSize: 17)
                  //                   .title,
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: KCard(
                      height: 80,
                      radius: 10,
                      color: kOpacity(kColor(context).primary, .5),
                      child: Column(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 5,
                            children: [
                              const Icon(
                                Icons.schedule,
                                size: 15,
                                color: Kolor.fadeText,
                              ),
                              Flexible(
                                child: Label(
                                  "Pending",
                                  color: Kolor.fadeText,
                                ).regular,
                              ),
                            ],
                          ),
                          Label(
                            "No Payments",
                            maxLines: 1,
                            fontSize: 17,
                            color: Kolor.fadeText,
                          ).title,
                        ],
                      ),
                    ),
                  ),
                  width10,
                  KCard(
                    onTap: () => context.push("/calculate"),
                    height: 80,
                    width: 80,
                    radius: 10,
                    child: FittedBox(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.calculate_outlined,
                            size: 25,
                          ),
                          height10,
                          Label("Rate", height: 1).regular,
                        ],
                      ),
                    ),
                  ),
                  width10,
                  KCard(
                    onTap: _scan,
                    height: 80,
                    width: 80,
                    radius: 10,
                    child: FittedBox(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.qr_code_scanner_sharp,
                            size: 20,
                          ),
                          height10,
                          Label("Scan", height: 1).regular,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              kHeight(40),
              Label("In Progress").title,
              height10,
              KCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Label("Shipping ID",
                                      color: Kolor.fadeText, fontSize: 15)
                                  .subtitle,
                              Label("273627362783", fontSize: 17).regular,
                            ],
                          ),
                        ),
                        width10,
                        Pill(
                          label: "on the way",
                          backgroundColor: kOpacity(Colors.amber.shade900, .1),
                          textColor: Colors.amber.shade800,
                        ).text
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: EasyStepper(
                        showTitle: false,
                        disableScroll: true,
                        activeStep: activeStep,
                        lineStyle: const LineStyle(
                          lineType: LineType.normal,
                          lineWidth: 0,
                          lineSpace: 0,
                          lineLength: 70,
                          defaultLineColor: Kolor.border,
                          finishedLineColor: Kolor.primary,
                        ),
                        activeStepTextColor: Colors.black87,
                        finishedStepTextColor: Colors.black87,
                        internalPadding: 15,
                        showLoadingAnimation: false,
                        stepRadius: 8,
                        showStepBorder: false,
                        fitWidth: true,
                        steps: List.generate(
                          5,
                          (index) => EasyStep(
                            customStep: CircleAvatar(
                              radius: 8,
                              backgroundColor: Kolor.border,
                              child: KCard(
                                radius: 100,
                                height: 20,
                                width: 20,
                                borderColor:
                                    activeStep >= index ? Kolor.border : null,
                                color: activeStep >= index
                                    ? Kolor.primary
                                    : Kolor.border,
                              ),
                            ),
                            title: '',
                          ),
                        ),
                        // onStepReached: (index) =>
                        //     setState(() => activeStep = index),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Label(
                                "Departure date",
                              ).subtitle,
                              Label("04 Dec 2024", fontSize: 17).regular,
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 30,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Label(
                                "Arrival date",
                              ).subtitle,
                              Label("31 Dec 2024", fontSize: 17).regular,
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              kHeight(40),
              Label("Track Your Package").title,
              height10,
              KSearchbar(
                controller: searchKey,
                textCapitalization: TextCapitalization.characters,
                hintText: "Enter Shipping Number",
              ),
              kHeight(40),
              Label("Today's Promo").title,
              height10,
              const KCarousel(
                isLooped: true,
                showIndicator: false,
                images: [
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUvaVk9-XOPXDK3WF_CUG3mo4WBMFOjT_gsQ&s",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAwv47Yj5IRxf9juIkVQrAh1cyUQJhiBT3fA&s"
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
