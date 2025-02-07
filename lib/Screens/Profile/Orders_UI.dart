import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Models/Courier_Model.dart';
import 'package:postr/Repository/orders_repo.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';
import '../../Components/Pill.dart';
import '../../Components/kWidgets.dart';
import '../../Resources/colors.dart';

class Orders_UI extends ConsumerStatefulWidget {
  const Orders_UI({super.key});

  @override
  ConsumerState<Orders_UI> createState() => _Orders_UIState();
}

class _Orders_UIState extends ConsumerState<Orders_UI> {
  final pageNo = ValueNotifier(0);
  String courierType = "Domestic";
  String status = "All";

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(ordersListFuture(jsonEncode({
      "pageNo": pageNo.value,
      "courierType": courierType,
      "status": status,
    })));

    final ordersList = ref.watch(ordersListProvider);
    return KScaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KHeading(
                  title: "Orders",
                  subtitle: "View all recent orders",
                  isLoading: asyncData.isLoading),
              ListView.separated(
                itemBuilder: (context, index) =>
                    buildHistoryTile(CourierModel.fromMap(ordersList[index])),
                separatorBuilder: (context, index) => height20,
                itemCount: ordersList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              if (ordersList.isEmpty && !asyncData.isLoading) kEmpty
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHistoryTile(CourierModel data) {
    return KCard(
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label("AWB Number", color: Kolor.fadeText, fontSize: 15)
                        .subtitle,
                    Label(data.awbNumber ?? "-", fontSize: 17).regular,
                  ],
                ),
              ),
              width10,
              Pill(
                label: data.status!,
                backgroundColor: kOpacity(
                    statusColorMap[data.status!] ?? Kolor.fadeText, .1),
                textColor: statusColorMap[data.status!] ?? Kolor.fadeText,
              ).text
            ],
          ),
          Row(
            spacing: 20,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label(
                      "Pickup",
                    ).subtitle,
                    Label(
                      data.fromAddress!.split(",").take(2).join(", "),
                      maxLines: 2,
                    ).regular,
                    height10,
                    Label(
                      "Departure date",
                    ).subtitle,
                    Label(kDateFormat(data.scheduleDate!), fontSize: 17)
                        .regular,
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward,
                size: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Label(
                      "Drop",
                    ).subtitle,
                    Label(
                      data.toAddress!.split(",").take(2).join(", "),
                      maxLines: 2,
                      textAlign: TextAlign.end,
                    ).regular,
                    height10,
                    Label(
                      "Arrival date",
                    ).subtitle,
                    Label("-", fontSize: 17).regular,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
