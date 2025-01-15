import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Components/kWidgets.dart';
import 'package:postr/Models/Courier_Model.dart';
import 'package:postr/Repository/courier_repo.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';
import '../../Components/kButton.dart';
import '../../Models/Address_Model.dart';
import '../../Resources/colors.dart';

class Checkout_UI extends ConsumerStatefulWidget {
  final CourierModel masterdata;
  const Checkout_UI({super.key, required this.masterdata});

  @override
  ConsumerState<Checkout_UI> createState() => _Checkout_UIState();
}

class _Checkout_UIState extends ConsumerState<Checkout_UI> {
  placeOrder() async {
    try {
      final res =
          await ref.read(courierRepository).placeOrder(data: widget.masterdata);
      if (!res.error) {
        context.go("/courier/cofirmation",
            extra: {"awbNumber": res.data["awbNumber"]});
      }

      KSnackbar(context, message: res.message, error: res.error);
    } catch (e) {
      KSnackbar(context, message: "$e", error: true);
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      appBar: AppBar(
        title: Label("3/3", color: kColor(context).primaryContainer).regular,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KHeading(title: "Checkout", subtitle: "Confirm for pickup"),
              Label("Pickup Details").title,
              height10,
              _addressCard(
                address: AddressModel(
                    name: widget.masterdata.fromName!,
                    phone: widget.masterdata.fromPhone!,
                    address: widget.masterdata.fromAddress!,
                    pincode: widget.masterdata.fromPincode!,
                    type: ""),
              ),
              height20,
              Label("Drop Details").title,
              height10,
              _addressCard(
                address: AddressModel(
                  name: widget.masterdata.toName!,
                  phone: widget.masterdata.toPhone!,
                  address: widget.masterdata.toAddress!,
                  pincode: widget.masterdata.toPincode!,
                  type: "",
                ),
              ),
              height20,
              KCard(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Label("Total Payable").title,
                        Label(kCurrencyFormat(1000)).title,
                      ],
                    )
                  ],
                ),
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
            onPressed: placeOrder,
            style: KButtonStyle.expanded,
            label: "Proceed to checkout",
          ),
        ),
      ),
    );
  }

  Widget _addressCard({AddressModel? address}) {
    return KCard(
      width: double.maxFinite,
      child: Column(
        spacing: 1,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Label(address?.name ?? "Name", fontWeight: 500).regular,
          Label("+91 ${address?.phone ?? "Phone"}", fontWeight: 300).regular,
          Label(address?.address ?? "Address", fontWeight: 300).regular,
          Label(address?.pincode ?? "Pincode", fontWeight: 300).regular,
        ],
      ),
    );
  }
}
