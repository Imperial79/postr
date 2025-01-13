import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Screens/Address/Addresses_UI.dart';
import 'package:postr/Screens/Auth/LoginUI.dart';
import 'package:postr/Screens/Calculate/CalculateUI.dart';
import 'package:postr/Screens/Calculate/CalculatedResultUI.dart';
import 'package:postr/Screens/Courier/New_Courier_UI.dart';
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
        if (authState.isLoading) {
          return '/splash';
        }

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
          path: '/new-courier',
          builder: (context, state) => const NewCourierUI(),
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

        // GoRoute(
        //   path: '/book/:type/:bookId',
        //   builder: (context, state) {
        //     final type = state.pathParameters["type"];
        //     final bookId = state.pathParameters["bookId"]!;
        //     switch (type) {
        //       case "regular":
        //         return Regular_Book_UI(bookId: bookId, bookType: type!);

        //       default:
        //         return const Scaffold(
        //           body: Center(
        //             child: Text("No Page Found!"),
        //           ),
        //         );
        //     }
        //   },
        // ),
        // GoRoute(
        //   path: '/about/:id',
        //   builder: (context, state) =>
        //       MigrateUI(id: state.pathParameters["id"] ?? "No Params"),
        // ),
      ],
    );
  },
);
