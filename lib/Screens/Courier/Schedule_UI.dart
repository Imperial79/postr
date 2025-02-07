import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/kButton.dart';
import 'package:postr/Components/kWidgets.dart';
import 'package:postr/Models/Courier_Model.dart';
import 'package:postr/Repository/courier_repo.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';

import '../../Components/Day_Picker.dart';
import '../../Resources/colors.dart';

class Schedule_UI extends ConsumerStatefulWidget {
  final CourierModel masterdata;
  const Schedule_UI({super.key, required this.masterdata});

  @override
  ConsumerState<Schedule_UI> createState() => _Checkout_UIState();
}

class _Checkout_UIState extends ConsumerState<Schedule_UI> {
  String selectedDate = "${DateTime.now()}";
  final isLoading = ValueNotifier(false);

  placeOrder() async {
    try {
      isLoading.value = true;

      final finalData = widget.masterdata.copyWith(scheduleDate: selectedDate);
      final res = await ref.read(courierRepository).placeOrder(
            data: finalData,
          );

      if (!res.error) {
        context.push("/courier/checkout", extra: {
          "masterdata": finalData.copyWith(
            id: res.data["id"],
            netPayable: parseToDouble(res.data["netPayable"]),
          ),
        });
      } else {
        KErrorAlert(context, message: res.message);
      }
    } catch (e) {
      KErrorAlert(context, message: "Error while placing order - $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      isLoading: isLoading,
      appBar: AppBar(
        title: Label("2/3", color: kColor(context).primaryContainer).regular,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding)
                    .copyWith(top: kPadding),
                child: KHeading(
                  title: "Schedule Pickup",
                  subtitle: "When should our pickup partner pick your package",
                ),
              ),
              DayPicker(
                showDatePicker: false,
                days: 10,
                activeColor: kColor(context).tertiary,
                inactiveCardColor: Kolor.card,
                foregroundColor: Colors.black,
                onSelected: (date) {
                  setState(() {
                    selectedDate = "$date";
                  });
                },
              ),
              div,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label("Selected Date").regular,
                    height5,
                    Label(
                            DateFormat("dd MMMM, yyyy").format(
                              DateTime.parse(selectedDate),
                            ),
                            fontSize: 25,
                            color: kColor(context).tertiaryContainer)
                        .title,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: KButton(
            onPressed: () {
              placeOrder();
            },
            icon: const Icon(
              Icons.arrow_right_alt_rounded,
            ),
            style: KButtonStyle.expanded,
            label: "Proceed to checkout",
          ),
        ),
      ),
    );
  }
}
