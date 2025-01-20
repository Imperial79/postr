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
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> placeOrder({required CourierModel data}) async {
    try {
      final res =
          await apiCallBack(path: "/courier/place-order", body: data.toMap());
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> confirmOrder({required int orderId}) async {
    try {
      final res = await apiCallBack(
          path: "/courier/confirm-order", body: {"orderId": orderId});
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
