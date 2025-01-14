import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postr/Helper/api_config.dart';
import 'package:postr/Models/Address_Model.dart';
import 'package:postr/Models/Response_Model.dart';

final addressRepository = Provider(
  (ref) => AddressRepo(),
);

final addressListFuture = FutureProvider.autoDispose<List<AddressModel>>(
  (ref) async {
    try {
      final res = await apiCallBack(path: "/address/fetch");
      if (!res.error) {
        return (res.data as List)
            .map(
              (e) => AddressModel.fromMap(e),
            )
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  },
);

class AddressRepo {
  Future<ResponseModel> addAddress(AddressModel address) async {
    try {
      final res =
          await apiCallBack(path: "/address/save", body: address.toMap());

      return res;
    } catch (e) {
      rethrow;
    }
  }
}
