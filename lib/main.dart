import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/theme.dart';
import 'Helper/router_config.dart';

void main() {
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
