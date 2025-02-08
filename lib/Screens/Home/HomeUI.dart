import 'dart:convert';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Components/KSearchbar.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/Pill.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Components/kCarousel.dart';
import 'package:postr/Models/Courier_Model.dart';
import 'package:postr/Repository/orders_repo.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    return RefreshIndicator(
      color: Kolor.primary,
      onRefresh: () => ref.refresh(ordersListFuture(jsonEncode({
        "pageNo": 0,
        "courierType": "Domestic",
        "status": "All",
      })).future),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                        color: Kolor.text,
                        fontVariations: [FontVariation.weight(500)],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                height20,
                Label("Welcome back, ${user.name.split(" ").first}").subtitle,
                Row(
                  children: [
                    Flexible(
                      child:
                          Label("Netaji Colony, Durgapur", fontSize: 18).title,
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
                height20,
                inProgress(),
                height20,
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
      ),
    );
  }

  Widget inProgress() {
    return Consumer(
      builder: (context, ref, child) {
        final asyncData = ref.watch(ordersListFuture(jsonEncode({
          "pageNo": 0,
          "courierType": "Domestic",
          "status": "All",
        })));

        final ordersList = ref.watch(ordersListProvider);
        CourierModel data = CourierModel.fromMap({});
        if (ordersList.isNotEmpty) data = CourierModel.fromMap(ordersList[0]);

        return Visibility(
          visible: data.id != 0,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Label("In Progress").title,
                  InkWell(
                    onTap: () => context.push("/orders"),
                    child: Label("View All", color: Kolor.primary).regular,
                  )
                ],
              ),
              Skeletonizer(
                enabled: asyncData.isLoading,
                child: KCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Label("AWB Number",
                                        color: Kolor.fadeText, fontSize: 15)
                                    .subtitle,
                                Label(data.awbNumber ?? "-", fontSize: 17)
                                    .regular,
                              ],
                            ),
                          ),
                          width10,
                          Pill(
                            label: data.status ?? "",
                            backgroundColor:
                                kOpacity(statusColorMap[data.status], .1),
                            textColor: statusColorMap[data.status],
                          ).text
                        ],
                      ),
                      height20,
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 30.0),
                      //   child: EasyStepper(
                      //     showTitle: false,
                      //     disableScroll: true,
                      //     activeStep: activeStep,
                      //     lineStyle: const LineStyle(
                      //       lineType: LineType.normal,
                      //       lineWidth: 0,
                      //       lineSpace: 0,
                      //       lineLength: 70,
                      //       defaultLineColor: Kolor.border,
                      //       finishedLineColor: Kolor.primary,
                      //     ),
                      //     activeStepTextColor: Kolor.scaffold87,
                      //     finishedStepTextColor: Kolor.scaffold87,
                      //     internalPadding: 15,
                      //     showLoadingAnimation: false,
                      //     stepRadius: 8,
                      //     showStepBorder: false,
                      //     fitWidth: true,
                      //     steps: List.generate(
                      //       5,
                      //       (index) => EasyStep(
                      //         customStep: CircleAvatar(
                      //           radius: 8,
                      //           backgroundColor: Kolor.border,
                      //           child: KCard(
                      //             radius: 100,
                      //             height: 20,
                      //             width: 20,
                      //             borderColor:
                      //                 activeStep >= index ? Kolor.border : null,
                      //             color: activeStep >= index
                      //                 ? Kolor.primary
                      //                 : Kolor.border,
                      //           ),
                      //         ),
                      //         title: '',
                      //       ),
                      //     ),
                      //     // onStepReached: (index) =>
                      //     //     setState(() => activeStep = index),
                      //   ),
                      // ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Label(
                                  "Pickup",
                                ).subtitle,
                                Label(data.fromAddress ?? "", fontSize: 15)
                                    .regular,
                                height10,
                                Label(
                                  "Departure date",
                                ).subtitle,
                                Label(kDateFormat(data.scheduleDate),
                                        fontSize: 15)
                                    .regular,
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 25,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Label("Drop", textAlign: TextAlign.end)
                                    .subtitle,
                                Label(data.toAddress ?? "",
                                        fontSize: 15, textAlign: TextAlign.end)
                                    .regular,
                                height10,
                                Label(
                                  "Arrival date",
                                ).subtitle,
                                Label("-", fontSize: 15).regular,
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              if (ordersList.length > 1)
                Align(
                  alignment: Alignment.bottomRight,
                  child: KCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child:
                        Label("+${ordersList.length - 1}", weight: 400).regular,
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
