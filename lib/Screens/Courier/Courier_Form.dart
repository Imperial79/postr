import 'package:flutter/material.dart';
import '../../Components/kCard.dart';
import '../../Components/kTextfield.dart';

class CourierForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController pincode;
  final TextEditingController address;
  final void Function()? onAddressTap;

  const CourierForm(
      {super.key,
      required this.formKey,
      required this.name,
      required this.phone,
      required this.pincode,
      required this.address,
      this.onAddressTap});

  @override
  Widget build(BuildContext context) {
    return KCard(
      width: double.maxFinite,
      child: Form(
        key: formKey,
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KTextfield(
              controller: name,
              label: "Name",
              hintText: "Eg. John Doe",
              autofillHints: [AutofillHints.name],
            ).regular,
            KTextfield(
              controller: phone,
              label: "Phone",
              keyboardType: TextInputType.phone,
              autofillHints: [AutofillHints.telephoneNumber],
              hintText: "Eg. 909××××199",
              prefixText: "+91",
            ).regular,
            KTextfield(
              controller: pincode,
              label: "Pincode",
              hintText: "Eg. 81××××",
              autofillHints: [AutofillHints.postalCode],
              keyboardType: TextInputType.number,
            ).regular,
            KTextfield(
              onTap: onAddressTap,
              controller: address,
              label: "Street Address",
              hintText: "Eg. ABC Street, Near Landmark",
              minLines: 2,
              maxLines: 2,
              autofillHints: [AutofillHints.fullStreetAddress],
            ).regular,
          ],
        ),
      ),
    );
  }
}
