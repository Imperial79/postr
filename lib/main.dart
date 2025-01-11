import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/theme.dart';
import 'package:postr/firebase_options.dart';
import 'Helper/router_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    systemColors();

    final routerConfig = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Postr',
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: routerConfig,
    );
  }
}
