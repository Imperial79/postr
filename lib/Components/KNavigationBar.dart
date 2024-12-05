import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';

final navigationProvider = StateProvider<int>(
  (ref) => 0,
);

class KNavigationBar extends StatelessWidget {
  const KNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15)
                .copyWith(top: 20),
            decoration: const BoxDecoration(
              color: Dark.card,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  btn(iconPath: "home", index: 0),
                  btn(iconPath: "home", index: 1),
                  kWidth(80),
                  btn(iconPath: "profile", index: 2),
                  btn(iconPath: "profile", index: 3),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Dark.primary,
              ),
              child: const Icon(
                Icons.add,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
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
                  colorFilter:
                      kSvgColor(isActive ? Colors.white : Dark.fadeText),
                  height: 20,
                ),
                kHeight(7),
                CircleAvatar(
                  radius: 2,
                  backgroundColor: isActive ? Colors.white : Dark.card,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
