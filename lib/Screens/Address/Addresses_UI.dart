// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Components/kButton.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Components/kTextfield.dart';
import 'package:postr/Models/Address_Model.dart';
import 'package:postr/Repository/address_repo.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Components/Label.dart';
import '../../Components/kWidgets.dart';

class Addresses_UI extends ConsumerStatefulWidget {
  const Addresses_UI({super.key});

  @override
  ConsumerState<Addresses_UI> createState() => _AddressesUIState();
}

class _AddressesUIState extends ConsumerState<Addresses_UI> {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  String type = "Home";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> addAddress() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final data = AddressModel(
        name: name.text.trim(),
        phone: phone.text.trim(),
        address: address.text.trim(),
        pincode: pincode.text.trim(),
        type: type,
      );

      final res = await ref.read(addressRepository).addAddress(data);
      if (!res.error) {
        ref.refresh(addressListFuture.future);
      }

      KSnackbar(context, message: res.message, error: res.error);
    } catch (e) {
      KSnackbar(context, message: "Error while adding address!", error: true);
    } finally {
      Navigator.pop(context);
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final addressList = ref.watch(addressListFuture);
    return RefreshIndicator(
      onRefresh: () => ref.refresh(addressListFuture.future),
      child: KScaffold(
        isLoading: isLoading,
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(kPadding).copyWith(bottom: 100),
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KHeading(title: "Select an address", subtitle: "or Add one"),
                addressList.when(
                  data: (data) => data.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 15,
                          children: [
                            Label("Recently added").regular,
                            ...data.map((e) => _addressCard(address: e)),
                          ],
                        )
                      : Center(
                          child: Column(
                            children: [
                              const Icon(
                                Icons.inbox,
                                size: 80,
                                color: Kolor.fadeText,
                              ),
                              Label("No Data", color: Kolor.fadeText).title,
                            ],
                          ),
                        ),
                  error: (error, stackTrace) => Center(
                    child: Label("$error").regular,
                  ),
                  loading: () => Skeletonizer(
                    enabled: true,
                    child: _addressCard(),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ValueListenableBuilder<bool>(
              valueListenable: isLoading,
              builder: (context, loading, _) {
                return KButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: !loading,
                      builder: (context) => addAddressDialog(),
                    );
                  },
                  label: "Add an address",
                  icon: const Icon(Icons.add),
                  style: KButtonStyle.outlined,
                  backgroundColor: Kolor.scaffold,
                  foregroundColor: kColor(context).primaryContainer,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget addAddressDialog() {
    return StatefulBuilder(
      builder: (context, setState) {
        return ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (context, loading, _) {
            return Dialog(
              backgroundColor: Kolor.card,
              insetPadding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(kPadding),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Label("Add new address", fontSize: 25, weight: 600).title,
                      Label("Enter details below", fontSize: 17).subtitle,
                      height20,
                      KTextfield(
                        controller: name,
                        readOnly: loading,
                        label: "Name",
                        hintText: "Eg. John Doe",
                        keyboardType: TextInputType.name,
                        autofillHints: [AutofillHints.name],
                        validator: (val) => KValidation.required(val),
                      ).regular,
                      height20,
                      KTextfield(
                        controller: phone,
                        readOnly: loading,
                        label: "Phone",
                        hintText: "Eg. 909××××××0",
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.phone,
                        autofillHints: [AutofillHints.telephoneNumber],
                        validator: (val) => KValidation.phone(val),
                      ).regular,
                      height20,
                      KTextfield(
                        controller: pincode,
                        readOnly: loading,
                        label: "Pincode",
                        hintText: "Eg. 000001",
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        autofillHints: [AutofillHints.postalCode],
                        validator: (val) => KValidation.required(val),
                      ).regular,
                      height20,
                      KTextfield(
                        controller: address,
                        readOnly: loading,
                        label: "Address",
                        hintText:
                            "Eg. ABC Street, Near Landmark, City XYZ - 000001",
                        maxLines: 2,
                        minLines: 2,
                        keyboardType: TextInputType.streetAddress,
                        autofillHints: [AutofillHints.postalAddress],
                        validator: (val) => KValidation.required(val),
                      ).regular,
                      height20,
                      Label("Address Type", weight: 400).regular,
                      height5,
                      Row(
                        spacing: 10,
                        children: [
                          buildTypeSelector(setState, "Home"),
                          buildTypeSelector(setState, "Work"),
                        ],
                      ),
                      height20,
                      Label("Proceed with details?",
                              color: kColor(context).primaryContainer)
                          .subtitle,
                      height5,
                      KButton(
                        onPressed: addAddress,
                        label: "Add Address",
                        isLoading: loading,
                        style: KButtonStyle.expanded,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildTypeSelector(StateSetter setState, String label) {
    final bool selected = type == label;
    return ChoiceChip(
      label:
          Label(label, color: !selected ? Kolor.fadeText : Kolor.text).regular,
      selectedColor: kColor(context).secondary,
      selected: selected,
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: kRadius(10),
        side: BorderSide(
            color: !selected ? Kolor.border : kColor(context).secondary),
      ),
      onSelected: (value) {
        setState(() {
          type = label;
        });
      },
    );
  }

  Widget _addressCard({AddressModel? address}) {
    return KCard(
      onTap: () {
        if (address != null) context.pop(address.toMap());
      },
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 10,
            children: [
              const Icon(Icons.home_outlined),
              Label(address?.type ?? "type").title,
            ],
          ),
          Row(
            spacing: 10,
            children: [
              const Icon(
                Icons.home_outlined,
                color: Colors.transparent,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label(address?.name ?? "Name", weight: 500).regular,
                    Label("+91 ${address?.phone ?? "Phone"}", weight: 300)
                        .regular,
                    Label(address?.address ?? "Address", weight: 300).regular,
                    Label(address?.pincode ?? "Pincode", weight: 300).regular,
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
