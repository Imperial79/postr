import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Components/Pill.dart';
import 'package:postr/Resources/colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return KScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 70),
                child: Center(
                  child: Column(
                    spacing: 10,
                    children: [
                      Label("Order #${widget.orderId}",
                              fontSize: 25, weight: 650)
                          .title,
                      Pill(
                        backgroundColor: kOpacity(StatusText.warning, .1),
                        textColor: StatusText.warning,
                        label: "Pending",
                        fontSize: 20,
                      ).text,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
