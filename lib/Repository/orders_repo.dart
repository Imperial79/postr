import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postr/Helper/api_config.dart';

final ordersListProvider = StateProvider(
  (ref) => [],
);

final ordersListFuture = FutureProvider.family.autoDispose<void, String>(
  (ref, params) async {
    final body = jsonDecode(params);
    final pageNo = body["pageNo"];
    final res = await apiCallBack(path: "/courier/fetch-history", body: body);

    if (!res.error) {
      final dataList = res.data as List;
      if (pageNo == 0) {
        ref.read(ordersListProvider.notifier).state = dataList;
      }
      ref.read(ordersListProvider.notifier).state.addAll(dataList);
    }
  },
);
