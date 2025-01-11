import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postr/Components/KSearchbar.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/Pill.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Components/kCarousel.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
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
              Label("Welcome back, Avishek").subtitle,
              Row(
                children: [
                  Flexible(
                    child: Label("Netaji Colony, Durgapur").title,
                  ),
                  width10,
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Dark.primary,
                    size: 30,
                  ),
                ],
              ),
              height20,
              Row(
                children: [
                  Expanded(
                    child: KCard(
                      height: 80,
                      radius: 10,
                      color: kColor(context).primary,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Label("My Balance").regular,
                          Row(
                            children: [
                              const Icon(Icons.wallet),
                              width10,
                              Flexible(
                                child: Label("INR 1,000", maxLines: 1).title,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  width10,
                  KCard(
                    height: 80,
                    width: 80,
                    radius: 10,
                    child: FittedBox(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 40,
                          ),
                          height10,
                          Label("Rate").regular,
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
                            size: 40,
                          ),
                          height10,
                          Label("Scan").regular,
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
                                      color: Dark.fadeText, fontSize: 15)
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
                          defaultLineColor: Dark.border,
                          finishedLineColor: Dark.primary,
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
                              backgroundColor: Dark.border,
                              child: KCard(
                                radius: 100,
                                height: 20,
                                width: 20,
                                borderColor:
                                    activeStep >= index ? Dark.border : null,
                                color: activeStep >= index
                                    ? Dark.primary
                                    : Dark.border,
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
