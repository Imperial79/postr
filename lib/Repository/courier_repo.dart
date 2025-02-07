import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Helper/api_config.dart';
import '../Models/Courier_Model.dart';
import '../Models/Response_Model.dart';

final courierRepository = Provider(
  (ref) => CourierRepo(),
);

class CourierRepo {
  Future<ResponseModel> getCityFromPin({
    required String pincode,
  }) async {
    try {
      final res = await apiCallBack(path: "/courier/pincode-details", body: {
        "pincode": pincode,
      });
      if (res.error) throw res.message;
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> calculateCharge({
    required String fromPincode,
    required String toPincode,
    required double weightInKg,
  }) async {
    try {
      final res = await apiCallBack(path: "/courier/calculate-charge", body: {
        "fromPincode": fromPincode,
        "toPincode": toPincode,
        "weightInKg": weightInKg,
      });
      if (res.error) throw res.message;
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> placeOrder({required CourierModel data}) async {
    try {
      Map<String, dynamic> finalData = data.toMap();
      finalData["isFragile"] = data.isFragile! ? "Y" : "N";
      final res =
          await apiCallBack(path: "/courier/place-order", body: finalData);
      if (res.error) throw res.message;
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> confirmOrder({required int orderId}) async {
    try {
      final res = await apiCallBack(
          path: "/courier/confirm-order", body: {"orderId": orderId});
      if (res.error) throw res.message;
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> generateOrder({required int orderId}) async {
    try {
      final res = await apiCallBack(
        path: '/courier/generate-payment-order',
        body: {
          'orderId': orderId,
        },
      );
      if (res.error) throw res.message;
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> paymentConfirmation({
    required int orderId,
    required String paymentOrderId,
  }) async {
    final res = await apiCallBack(
      path: '/courier/verify-payment',
      body: {
        'orderId': orderId,
        'paymentOrderId': paymentOrderId,
      },
    );
    if (res.error) throw res.message;
    return res;
  }
}
