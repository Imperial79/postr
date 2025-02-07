import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postr/Components/KNavigationBar.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Screens/Calculate/CalculateUI.dart';
import 'package:postr/Screens/Home/HomeUI.dart';
import 'package:postr/Screens/Profile/profileUI.dart';

class RootUI extends ConsumerStatefulWidget {
  const RootUI({super.key});

  @override
  ConsumerState<RootUI> createState() => _RootUIState();
}

class _RootUIState extends ConsumerState<RootUI> {
  final List<Widget> _screens = [
    const HomeUI(),
    const CalculateUI(),
    const ProfileUI(),
    const ProfileUI(),
  ];
  @override
  Widget build(BuildContext context) {
    final activePage = ref.watch(navigationProvider);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageTransitionSwitcher(
            transitionBuilder: (child, animation, secondaryAnimation) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                fillColor: Kolor.scaffold,
                child: child,
              );
            },
            child: _screens[activePage],
          ),
          const KNavigationBar(),
        ],
      ),
    );
  }
}
