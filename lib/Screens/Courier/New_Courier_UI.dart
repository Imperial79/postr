import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/kButton.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Models/Address_Model.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';
import 'package:postr/Screens/Courier/Courier_Form.dart';

class NewCourierUI extends StatefulWidget {
  const NewCourierUI({super.key});

  @override
  State<NewCourierUI> createState() => _NewCourierUIState();
}

class _NewCourierUIState extends State<NewCourierUI> {
  final GlobalKey<FormState> pickupFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> dropFormKey = GlobalKey<FormState>();

  final TextEditingController pickupName = TextEditingController();
  final TextEditingController pickupPhone = TextEditingController();
  final TextEditingController pickupPincode = TextEditingController();
  final TextEditingController pickupAddress = TextEditingController();

  final TextEditingController dropName = TextEditingController();
  final TextEditingController dropPhone = TextEditingController();
  final TextEditingController dropPincode = TextEditingController();
  final TextEditingController dropAddress = TextEditingController();

  @override
  void dispose() {
    pickupName.dispose();
    pickupPhone.dispose();
    pickupPincode.dispose();
    pickupAddress.dispose();
    dropName.dispose();
    dropPhone.dispose();
    dropPincode.dispose();
    dropAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 70),
                child: Center(
                  child: Column(
                    children: [
                      Label("New Courier?", fontSize: 25, fontWeight: 800)
                          .title,
                      Label("Enter details", fontSize: 20, fontWeight: 200)
                          .title,
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Label("Pickup Details").title,
                  const Spacer(),
                  TextButton(onPressed: () {}, child: Label("Choose").regular)
                ],
              ),
              CourierForm(
                formKey: pickupFormKey,
                name: pickupName,
                phone: pickupPhone,
                pincode: pickupPincode,
                address: pickupAddress,
                onAddressTap: () async {
                  final result = await context.push("/addresses");
                  if (result != null && result is Map<String, dynamic>) {
                    final address = AddressModel.fromMap(result);
                    log("$address");
                  }
                },
              ),
              height20,
              Row(
                children: [
                  Label("Drop Details").title,
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Label("Choose").regular,
                  ),
                ],
              ),
              CourierForm(
                formKey: dropFormKey,
                name: dropName,
                phone: dropPhone,
                pincode: dropPincode,
                address: dropAddress,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: KCard(
        radius: 25,
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Label("Proceed with the details?",
                      color: kColor(context).primaryContainer)
                  .subtitle,
              KButton(
                onPressed: () {},
                label: "Proceed",
                backgroundColor: kColor(context).primary,
                icon: const Icon(
                  Icons.arrow_right_alt_rounded,
                  size: 25,
                ),
                style: KButtonStyle.expanded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
