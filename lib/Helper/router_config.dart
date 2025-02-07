import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Screens/Address/Addresses_UI.dart';
import 'package:postr/Screens/Auth/LoginUI.dart';
import 'package:postr/Screens/Calculate/CalculateUI.dart';
import 'package:postr/Screens/Calculate/CalculatedResultUI.dart';
import 'package:postr/Screens/Courier/Checkout_UI.dart';
import 'package:postr/Screens/Courier/Confirmation_UI.dart';
import 'package:postr/Screens/Courier/Courier_UI.dart';
import 'package:postr/Screens/Courier/Package_UI.dart';
import 'package:postr/Screens/Courier/Schedule_UI.dart';
import 'package:postr/Screens/Profile/Orders_UI.dart';
import 'package:postr/Screens/RootUI.dart';
import '../Repository/Auth/auth_repo.dart';
import '../Screens/SplashUI.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final authState = ref.watch(authFuture);
    final user = ref.watch(userProvider);

    return GoRouter(
      initialLocation: '/',
      redirect: (context, state) {
        if (authState.isLoading) return '/splash';
        if (user == null && state.fullPath != '/login') return '/login';
        if (user != null && state.fullPath == '/login') return '/';
        return null;
      },
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashUI(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginUI(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const RootUI(),
        ),
        GoRoute(
          path: '/courier',
          builder: (context, state) => const Courier_UI(),
          routes: [
            GoRoute(
              path: 'package',
              builder: (context, state) {
                final extra = state.extra;
                final masterdata = (extra is Map<String, dynamic>)
                    ? extra["masterdata"]
                    : null;

                return Package_UI(
                  masterdata: masterdata,
                );
              },
            ),
            GoRoute(
              path: 'schedule',
              builder: (context, state) {
                final extra = state.extra;
                final masterdata = (extra is Map<String, dynamic>)
                    ? extra["masterdata"]
                    : null;

                return Schedule_UI(
                  masterdata: masterdata,
                );
              },
            ),
            GoRoute(
              path: 'checkout',
              builder: (context, state) {
                final extra = state.extra;
                final masterdata = (extra is Map<String, dynamic>)
                    ? extra["masterdata"]
                    : null;

                return Checkout_UI(
                  masterdata: masterdata,
                );
              },
            ),
            GoRoute(
              path: 'confirmation',
              builder: (context, state) {
                final extra = state.extra;
                final masterdata = (extra is Map<String, dynamic>)
                    ? extra["masterdata"]
                    : null;

                return Confirmation_UI(
                  masterdata: masterdata,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/addresses',
          builder: (context, state) => const Addresses_UI(),
        ),
        GoRoute(
          path: '/calculate',
          builder: (context, state) => const CalculateUI(),
          routes: [
            GoRoute(
              path: 'calculated-result',
              builder: (context, state) {
                final extra = state.extra;
                final amount =
                    (extra is Map<String, dynamic>) ? extra["amount"] : null;
                return CalculatedResultUI(
                  amount: amount,
                );
              },
            ),
          ],
        ),
        GoRoute(
            path: '/orders',
            builder: (context, state) {
              return const Orders_UI();
            },
            routes: [
              GoRoute(
                path: 'track/:orderId',
                builder: (context, state) {
                  final orderId = (state is Map<String, dynamic>)
                      ? state.pathParameters["orderId"]
                      : null;
                  return const SizedBox();
                },
              ),
            ]),
      ],
    );
  },
);
