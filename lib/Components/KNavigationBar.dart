import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';

final navigationProvider = StateProvider<int>(
  (ref) => 0,
);

class KNavigationBar extends StatefulWidget {
  const KNavigationBar({super.key});

  @override
  State<KNavigationBar> createState() => _KNavigationBarState();
}

class _KNavigationBarState extends State<KNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isVisible) {
      return SizedBox(
        height: !isVisible ? 130 : 0,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 15)
                          .copyWith(top: 20),
                  decoration: BoxDecoration(
                    color: DColor.card.withAlpha((.8 * 255).round()),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        btn(iconPath: "home", index: 0),
                        btn(iconPath: "calculator", index: 1),
                        kWidth(80),
                        btn(iconPath: "profile", index: 2),
                        btn(iconPath: "profile", index: 3),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: KCard(
                onTap: () {
                  context.push("/new-courier");
                },
                padding: const EdgeInsets.all(10),
                color: DColor.primary,
                radius: 100,
                child: const Icon(
                  Icons.add,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget btn({required String iconPath, required int index}) {
    return Expanded(
      child: Consumer(
        builder: (context, ref, _) {
          final isActive = ref.watch(navigationProvider) == index;
          return IconButton(
            onPressed: () {
              ref.read(navigationProvider.notifier).state = index;
            },
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  isActive
                      ? "$kIconPath/$iconPath-filled.svg"
                      : "$kIconPath/$iconPath.svg",
                  colorFilter: ColorFilter.mode(
                    isActive ? DColor.primary : DColor.fadeText,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
