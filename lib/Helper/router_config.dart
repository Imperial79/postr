import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Screens/Auth/LoginUI.dart';
import 'package:postr/Screens/RootUI.dart';
import '../Screens/SplashUI.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    // final authState = ref.watch(authFuture);
    // final user = ref.watch(userProvider);

    bool isLoading = 1 == 1;

    return GoRouter(
      initialLocation: '/login', // Set the initial route to root
      redirect: (context, state) {
        // Show splash screen while auth is loading
        if (!isLoading) {
          return '/splash';
        }
        // Redirect logic based on authentication state
        // if (user == null && state.fullPath != '/login') return '/login';
        // if (user != null && state.fullPath == '/login') return '/home';

        return null;
      },
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashUI(),
        ),
        // GoRoute(
        //   path: '/login',
        //   builder: (context, state) => const LoginUI(),
        // ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginUI(),
        ),
        GoRoute(
          path: '/root',
          builder: (context, state) => const RootUI(),
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
