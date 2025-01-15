import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Components/Label.dart';
import '../../Components/kCard.dart';
import '../../Components/kTextfield.dart';
import '../../Repository/courier_repo.dart';
import '../../Resources/colors.dart';
import '../../Resources/commons.dart';

class CourierForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController pincode;
  final TextEditingController address;

  const CourierForm({
    super.key,
    required this.formKey,
    required this.name,
    required this.phone,
    required this.pincode,
    required this.address,
  });

  @override
  ConsumerState<CourierForm> createState() => _CourierFormState();
}

class _CourierFormState extends ConsumerState<CourierForm> {
  String fetchingFor = "";
  String cityDetails = "";
  bool isLoading = false;

  @override
  void initState() {
    widget.pincode.addListener(() {
      if (widget.pincode.text.length == 6) {
        searchPinCode(widget.pincode.text);
      }
    });
    super.initState();
  }

  Future<void> searchPinCode(String pincode) async {
    try {
      setState(() {
        isLoading = true;
      });
      final res =
          await ref.read(courierRepository).getCityFromPin(pincode: pincode);

      if (!res.error) {
        String cityRes =
            "${res.data["postOffice"]}, ${res.data["taluk"]}, ${res.data["district"]}, ${res.data["state"]}";
        setState(() {
          cityDetails = cityRes;
        });
      } else {
        KSnackbar(context, message: res.message, error: true);
      }
    } catch (e) {
      KSnackbar(context,
          message: "Error while fetching city details. $e", error: true);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return KCard(
      width: double.maxFinite,
      child: Form(
        key: widget.formKey,
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KTextfield(
              controller: widget.name,
              label: "Name",
              hintText: "Eg. John Doe",
              autofillHints: [AutofillHints.name],
            ).regular,
            KTextfield(
              controller: widget.phone,
              label: "Phone",
              maxLength: 10,
              keyboardType: TextInputType.phone,
              autofillHints: [AutofillHints.telephoneNumber],
              hintText: "Eg. 909××××199",
              prefixText: "+91",
            ).regular,
            KTextfield(
              controller: widget.pincode,
              label: "Pincode",
              maxLength: 6,
              hintText: "Eg. 81××××",
              suffix: isLoading ? _smallLoading() : null,
              autofillHints: [AutofillHints.postalCode],
              keyboardType: TextInputType.number,
            ).regular,
            if (cityDetails.isNotEmpty)
              Row(
                spacing: 10,
                children: [
                  const Icon(Icons.location_on, color: StatusText.success),
                  Expanded(
                    child: Label(
                      cityDetails,
                      fontWeight: 400,
                    ).regular,
                  ),
                ],
              ),
            KTextfield(
              controller: widget.address,
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
