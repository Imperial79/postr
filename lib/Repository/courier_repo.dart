import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Helper/api_config.dart';
import '../Models/Response_Model.dart';

final courierRepository = Provider(
  (ref) => CourierRepo(),
);

class CourierRepo {
  Future<ResponseModel> getCityFromPin({
    required String pincode,
    required String type,
  }) async {
    try {
      final res = await apiCallBack(path: "/courier/pincode-details", body: {
        "pincode": pincode,
        "type": type,
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
}
