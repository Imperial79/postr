import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/kButton.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Models/Address_Model.dart';
import 'package:postr/Models/Courier_Model.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';
import 'package:postr/Screens/Courier/Courier_Form.dart';

class Courier_UI extends ConsumerStatefulWidget {
  const Courier_UI({super.key});

  @override
  ConsumerState<Courier_UI> createState() => _Courier_UIState();
}

class _Courier_UIState extends ConsumerState<Courier_UI> {
  final GlobalKey<FormState> fromFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> toFormKey = GlobalKey<FormState>();

  final TextEditingController fromName = TextEditingController();
  final TextEditingController fromPhone = TextEditingController();
  final TextEditingController fromPincode = TextEditingController();
  final TextEditingController fromAddress = TextEditingController();

  final TextEditingController toName = TextEditingController();
  final TextEditingController toPhone = TextEditingController();
  final TextEditingController toPincode = TextEditingController();
  final TextEditingController toAddress = TextEditingController();

  @override
  void dispose() {
    fromName.dispose();
    fromPhone.dispose();
    fromPincode.dispose();
    fromAddress.dispose();
    toName.dispose();
    toPhone.dispose();
    toPincode.dispose();
    toAddress.dispose();
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
                  TextButton(
                      onPressed: () async {
                        final result = await context.push("/addresses");
                        if (result != null && result is Map<String, dynamic>) {
                          final address = AddressModel.fromMap(result);

                          setState(() {
                            fromName.text = address.name;
                            fromPhone.text = address.phone;
                            fromPincode.text = address.pincode;
                            fromAddress.text = address.address;
                          });
                        }
                      },
                      child: Label("Choose").regular)
                ],
              ),
              CourierForm(
                formKey: fromFormKey,
                name: fromName,
                phone: fromPhone,
                pincode: fromPincode,
                address: fromAddress,
              ),
              height20,
              Row(
                children: [
                  Label("Drop Details").title,
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      final result = await context.push("/addresses");
                      if (result != null && result is Map<String, dynamic>) {
                        final address = AddressModel.fromMap(result);

                        setState(() {
                          toName.text = address.name;
                          toPhone.text = address.phone;
                          toPincode.text = address.pincode;
                          toAddress.text = address.address;
                        });
                      }
                    },
                    child: Label("Choose").regular,
                  ),
                ],
              ),
              CourierForm(
                formKey: toFormKey,
                name: toName,
                phone: toPhone,
                pincode: toPincode,
                address: toAddress,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: MediaQuery.of(context).viewInsets.bottom == 0
            ? KCard(
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
                        onPressed: () {
                          if (fromFormKey.currentState!.validate() &&
                              toFormKey.currentState!.validate()) {
                            final masterdata = CourierModel(
                              fromName: fromName.text,
                              fromPhone: fromPhone.text,
                              fromPincode: fromPincode.text,
                              fromAddress: fromAddress.text,
                              toName: toName.text,
                              toPhone: toPhone.text,
                              toPincode: toPincode.text,
                              toAddress: toAddress.text,
                            );
                            context.push("/courier/package",
                                extra: {"masterdata": masterdata});
                          }
                        },
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
              )
            : const SizedBox(),
      ),
    );
  }
}
