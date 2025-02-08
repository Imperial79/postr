// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Components/Pill.dart';
import 'package:postr/Components/kButton.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Repository/courier_repo.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';
import '../../Components/Label.dart';

class Order_Detail_UI extends ConsumerStatefulWidget {
  final int orderId;
  const Order_Detail_UI({
    super.key,
    required this.orderId,
  });

  @override
  ConsumerState<Order_Detail_UI> createState() => _Order_Detail_UIState();
}

class _Order_Detail_UIState extends ConsumerState<Order_Detail_UI> {
  final ScrollController _scrollController = ScrollController();
  final _isPastPendingLabel = ValueNotifier(false);
  final GlobalKey _pendingLabelKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final RenderBox renderBox =
        _pendingLabelKey.currentContext?.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero).dy;
    if (position < 0 && !_isPastPendingLabel.value) {
      _isPastPendingLabel.value = true;
    } else if (position >= 0 && _isPastPendingLabel.value) {
      _isPastPendingLabel.value = false;
    }
  }

  Future<void> _refresh() async {
    await ref.refresh(orderDetailFuture(widget.orderId).future);
  }

  @override
  Widget build(BuildContext context) {
    final orderData = ref.watch(orderDetailFuture(widget.orderId));
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ValueListenableBuilder(
          valueListenable: _isPastPendingLabel,
          builder: (context, isVisible, child) {
            return KScaffold(
              appBar: AppBar(
                title: isVisible
                    ? Label("Order #${widget.orderId}").regular
                    : const SizedBox(),
                actions: [
                  if (orderData.hasValue &&
                      orderData.value != null &&
                      isVisible)
                    Pill(
                      backgroundColor:
                          kOpacity(statusColorMap[orderData.value?.status], .1),
                      textColor: statusColorMap[orderData.value?.status],
                      label: orderData.value?.status ?? "Pending",
                      fontSize: 12,
                    ).text,
                  width20,
                ],
              ),
              body: SafeArea(
                child: orderData.when(
                  data: (data) => data != null
                      ? SingleChildScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(kPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 70),
                                child: Center(
                                  child: Column(
                                    key: _pendingLabelKey,
                                    children: [
                                      Label("Order #${widget.orderId}",
                                              fontSize: 25, weight: 650)
                                          .title,
                                      Pill(
                                        backgroundColor: kOpacity(
                                            statusColorMap[data.status!], .1),
                                        textColor: statusColorMap[data.status!],
                                        label: data.status!,
                                        fontSize: 20,
                                      ).text,
                                    ],
                                  ),
                                ),
                              ),
                              KCard(
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Label("Payment Pending",
                                                  color: StatusText.warning)
                                              .title,
                                          Label(
                                            "Please pay the pending amount to initiate pickup",
                                            weight: 400,
                                          ).regular,
                                        ],
                                      ),
                                    ),
                                    KButton(
                                      onPressed: () {},
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      label:
                                          "Pay ${kCurrencyFormat(data.netPayable, symbol: "₹")}",
                                      radius: 100,
                                    ),
                                  ],
                                ),
                              ),
                              height20,
                              Label("Shipping Details").regular,
                              div,
                              KCard(
                                width: double.infinity,
                                borderWidth: 1,
                                borderColor: Kolor.border,
                                color: Kolor.scaffold,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Label("Pickup Location").subtitle,
                                    height10,
                                    Label(data.fromName!, weight: 400).regular,
                                    Label("+91 ${data.fromPhone!}", weight: 400)
                                        .regular,
                                    kHeight(5),
                                    Label(data.fromAddress!, weight: 400)
                                        .regular,
                                  ],
                                ),
                              ),
                              height10,
                              KCard(
                                width: double.infinity,
                                borderWidth: 1,
                                borderColor: Kolor.border,
                                color: Kolor.scaffold,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Label("Drop Location").subtitle,
                                    height10,
                                    Label(data.toName!, weight: 400).regular,
                                    Label("+91 ${data.toPhone!}", weight: 400)
                                        .regular,
                                    kHeight(5),
                                    Label(data.toAddress!, weight: 400).regular,
                                  ],
                                ),
                              ),
                              height20,
                              Label("Package Details").regular,
                              div,
                              height10,
                              GridView(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 50,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Label("Courier Type").subtitle,
                                      Label(data.packageType!, fontSize: 17)
                                          .title,
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Label("Package Value").subtitle,
                                      Label(kCurrencyFormat(data.packageValue),
                                              fontSize: 17)
                                          .title,
                                    ],
                                  ),
                                  if (data.packageType == "Non-Document")
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Label("Content").subtitle,
                                        Label(data.packageContent!,
                                                fontSize: 17)
                                            .title,
                                      ],
                                    ),
                                  if (data.packageType == "Non-Document")
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Label("L × W × H").subtitle,
                                        Label("${data.length} × ${data.width} × ${data.height}",
                                                fontSize: 17)
                                            .title,
                                      ],
                                    ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Label("Weight").subtitle,
                                      Label(kConvertToGram(data.weightInKg),
                                              fontSize: 17)
                                          .title,
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      : kNodata(
                          showRetry: true,
                          onPressed: _refresh,
                        ),
                  error: (error, stackTrace) => kNodata(
                    showRetry: true,
                    onPressed: _refresh,
                  ),
                  loading: () => kLoading,
                  skipLoadingOnRefresh: false,
                ),
              ),
            );
          }),
    );
  }
}
