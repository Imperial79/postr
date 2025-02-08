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
  final isLoading = ValueNotifier(false);

  // var cfPaymentGatewayService = CFPaymentGatewayService();

  // @override
  // void initState() {
  //   super.initState();
  //   cfPaymentGatewayService.setCallback(verifyPayment, onError);
  // }

  // generateOrder() async {
  //   try {
  //     isLoading.value = true;

  //     final res = await ref.read(courierRepository).generateOrder(
  //           orderId: widget.masterdata.id!,
  //         );

  //     await makePayment(res.data['order_id'], res.data['payment_session_id']);
  //   } catch (e) {
  //     KSnackbar(context, message: "$e", error: true);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // CFSession? createSession(String orderId, String sessionId) {
  //   try {
  //     var session = CFSessionBuilder()
  //         .setEnvironment(CFEnvironment.SANDBOX)
  //         .setOrderId(orderId)
  //         .setPaymentSessionId(sessionId)
  //         .build();
  //     return session;
  //   } on CFException catch (e) {
  //     KSnackbar(context, message: e.message, error: true);
  //     rethrow;
  //   }
  // }

  // makePayment(String orderId, String sessionId) async {
  //   try {
  //     isLoading.value = true;

  //     var session = createSession(orderId, sessionId);
  //     var cfWebCheckout =
  //         CFWebCheckoutPaymentBuilder().setSession(session!).build();
  //     cfPaymentGatewayService.doPayment(cfWebCheckout);
  //   } on CFException catch (e) {
  //     KSnackbar(context, message: e.message, error: true);
  //     rethrow;
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // void verifyPayment(String paymentOrderId) async {
  //   try {
  //     isLoading.value = true;

  //     final res = await ref.read(courierRepository).paymentConfirmation(
  //           orderId: widget.masterdata.id!,
  //           paymentOrderId: paymentOrderId,
  //         );
  //     confirmPickup();
  //     KSnackbar(context, res: res);
  //   } catch (e) {
  //     KSnackbar(context, message: "$e", error: true);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // void onError(CFErrorResponse errorResponse, String orderId) {
  //   isLoading.value = false;

  //   KSnackbar(
  //     context,
  //     message: "Payment ${errorResponse.getStatus()}",
  //     error: true,
  //   );
  // }

  confirmPickup() async {
    try {
      isLoading.value = true;

      final res = await ref
          .read(courierRepository)
          .confirmOrder(orderId: widget.masterdata.id!);

      if (!res.error) {
        context.go("/courier/confirmation",
            extra: {"masterdata": widget.masterdata.copyWith(txnId: res.data)});
      } else {
        KErrorAlert(context, message: res.message);
      }
    } catch (e) {
      KErrorAlert(context, message: e);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      isLoading: isLoading,
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
                  type: "",
                ),
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
                        Label(kCurrencyFormat(widget.masterdata.netPayable))
                            .title,
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
            onPressed: confirmPickup,
            style: KButtonStyle.expanded,
            label: "Confirm Pickup",
            fontSize: 17,
            weight: 700,
            backgroundColor: Kolor.primary,
            foregroundColor: Kolor.scaffold,
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
          Label(address?.name ?? "Name", weight: 500).title,
          Label("+91 ${address?.phone ?? "Phone"}", weight: 300).regular,
          height5,
          Label(address?.address ?? "Address", weight: 300).subtitle,
          Label(address?.pincode ?? "Pincode", weight: 300).subtitle,
        ],
      ),
    );
  }
}
