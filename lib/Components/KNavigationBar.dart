import 'package:flutter/material.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';

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
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Dark.card,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  btn(),
                  btn(),
                  kWidth(80),
                  btn(),
                  btn(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                // gradient: RadialGradient(
                //   colors: [
                //     kColor(context).primaryContainer,
                //     Dark.primary,
                //   ],
                // ),
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

  Widget btn() {
    return Expanded(
      child: IconButton(
        onPressed: () {},
        icon: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.home,
              size: 30,
            ),
            height5,
            CircleAvatar(
              radius: 2,
              backgroundColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
