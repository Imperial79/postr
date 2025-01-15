import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/kButton.dart';
import 'package:postr/Components/kWidgets.dart';
import 'package:postr/Models/Courier_Model.dart';
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
  @override
  Widget build(BuildContext context) {
    return KScaffold(
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
                inactiveCardColor: DColor.card,
                foregroundColor: Colors.black,
                onSelected: (date) {
                  setState(() {
                    selectedDate = "$date";
                  });
                },
              ),
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
              context.push("/courier/checkout", extra: {
                "masterdata":
                    widget.masterdata.copyWith(scheduleDate: selectedDate),
              });
            },
            style: KButtonStyle.expanded,
            label: "Proceed to checkout",
          ),
        ),
      ),
    );
  }
}
