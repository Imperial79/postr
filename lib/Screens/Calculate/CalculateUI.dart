import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/kButton.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Components/kTextfield.dart';
import 'package:postr/Components/kWidgets.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';

import '../../Repository/courier_repo.dart';

class CalculateUI extends ConsumerStatefulWidget {
  const CalculateUI({super.key});

  @override
  ConsumerState<CalculateUI> createState() => _CalculateUIState();
}

class _CalculateUIState extends ConsumerState<CalculateUI> {
  final formKey = GlobalKey<FormState>();
  String selectedUnit = "GM";
  ValueNotifier isLoading = ValueNotifier(false);
  final fromPin = TextEditingController();
  String fetchingFor = "";
  String fromPinCity = "";
  String toPinCity = "";
  final toPin = TextEditingController();
  final weight = TextEditingController();
  Future<void> searchPinCode(String pincode, String type) async {
    try {
      setState(() {
        fetchingFor = type;
      });
      final res =
          await ref.read(courierRepository).getCityFromPin(pincode: pincode);

      if (!res.error) {
        String cityRes =
            "${res.data["postOffice"]}, ${res.data["taluk"]}, ${res.data["district"]}, ${res.data["state"]}";
        setState(() {
          if (type == "Pickup") {
            fromPinCity = cityRes;
          } else {
            toPinCity = cityRes;
          }
        });
      } else {
        KSnackbar(context, message: res.message, error: true);
      }
    } catch (e) {
      KSnackbar(context,
          message: "Error while fetching city details. $e", error: true);
    } finally {
      setState(() {
        fetchingFor = "";
      });
    }
  }

  Future<void> calculate() async {
    try {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        final res = await ref.read(courierRepository).calculateCharge(
              fromPincode: fromPin.text.trim(),
              toPincode: toPin.text.trim(),
              weightInKg: selectedUnit == "KG"
                  ? parseToDouble(weight.text)
                  : parseToDouble(weight.text) / 1000,
            );

        if (!res.error) {
          context.push("/calculate/calculated-result", extra: {
            "amount": parseToDouble(res.data),
          }).then(
            (value) {
              fromPin.clear();
              toPin.clear();
              weight.clear();
              fromPinCity = "";
              toPinCity = "";
              setState(() {});
            },
          );
        } else {
          KSnackbar(context, message: res.message, error: res.error);
        }
      }
    } catch (e) {
      KSnackbar(context, message: "Error while calculating.", error: true);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    fromPin.dispose();
    toPin.dispose();
    weight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      isLoading: isLoading,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPadding),
          child: Form(
            key: formKey,
            child: Column(
              spacing: 15,
              children: [
                KHeading(title: "Calculate", subtitle: "Courier Charges"),
                KCard(
                  width: double.maxFinite,
                  child: Column(
                    spacing: 15,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Label("Destination").title,
                      KTextfield(
                        controller: fromPin,
                        prefix: const Icon(
                          Icons.map,
                          color: Colors.white,
                          size: 23,
                        ),
                        suffix: fetchingFor == "Pickup"
                            ? _smallLoading()
                            : const SizedBox(),
                        label: "Sender Pincode",
                        showRequired: false,
                        maxLength: 6,
                        hintText: "Sender pincode",
                        keyboardType: TextInputType.number,
                        autofillHints: [AutofillHints.postalCode],
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (val) {
                          if (val.length == 6) {
                            searchPinCode(val, "Pickup");
                          }
                        },
                        validator: (val) => KValidation.required(val),
                      ).regular,
                      if (fromPinCity.isNotEmpty) ...[
                        Row(
                          spacing: 10,
                          children: [
                            const Icon(Icons.location_on,
                                color: StatusText.success),
                            Expanded(
                              child: Label(
                                fromPinCity,
                                // color: colwhite,
                                fontWeight: 400,
                              ).regular,
                            ),
                          ],
                        )
                      ],
                      KTextfield(
                        controller: toPin,
                        prefix: const Icon(
                          Icons.map,
                          color: Colors.white,
                          size: 23,
                        ),
                        suffix: fetchingFor == "Drop"
                            ? _smallLoading()
                            : const SizedBox(),
                        label: "Receiver Pincode",
                        showRequired: false,
                        maxLength: 6,
                        hintText: "Receiver pincode",
                        keyboardType: TextInputType.number,
                        autofillHints: [AutofillHints.postalCode],
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (val) {
                          if (val.length == 6) {
                            searchPinCode(val, "Drop");
                          }
                        },
                        validator: (val) => KValidation.required(val),
                      ).regular,
                      if (toPinCity.isNotEmpty) ...[
                        Row(
                          spacing: 10,
                          children: [
                            const Icon(Icons.location_on,
                                color: StatusText.success),
                            Expanded(
                              child: Label(
                                toPinCity,
                                // color: colwhite,
                                fontWeight: 400,
                              ).regular,
                            ),
                          ],
                        )
                      ],
                      Row(
                        spacing: 10,
                        children: [
                          Flexible(
                            child: KTextfield(
                              controller: weight,
                              prefix: const Icon(
                                Icons.scale,
                                color: Colors.white,
                                size: 23,
                              ),
                              suffix: DropdownButton<String>(
                                underline: const SizedBox.shrink(),
                                value: selectedUnit,
                                items: <String>["KG", "GM"].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedUnit = newValue!;
                                  });
                                },
                              ),
                              label: "Approx Weight",
                              showRequired: false,
                              hintText: "Approx Weight",
                              keyboardType: TextInputType.number,
                              validator: (val) => KValidation.required(val),
                            ).regular,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                KButton(
                  onPressed: () {
                    calculate();
                  },
                  backgroundColor: kColor(context).tertiary,
                  label: "Calculate",
                  icon: const Icon(
                    Icons.calculate,
                    size: 25,
                  ),
                  style: KButtonStyle.expanded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _smallLoading() {
    return const SizedBox(
      height: 15,
      width: 15,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: DColor.primary,
      ),
    );
  }
}
