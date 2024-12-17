// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:postr/Resources/colors.dart';

import '../Resources/commons.dart';
import '../Resources/constants.dart';
import 'Label.dart';

// ignore: must_be_immutable
class KScaffold extends StatefulWidget {
  PreferredSizeWidget? appBar;
  final Widget body;
  FloatingActionButtonLocation? floatingActionButtonLocation;
  FloatingActionButtonAnimator? floatingActionButtonAnimator;
  Widget? floatingActionButton;
  bool isLoading;
  KScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.isLoading = false,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
  });

  @override
  State<KScaffold> createState() => _KScaffoldState();
}

class _KScaffoldState extends State<KScaffold> {
  @override
  Widget build(BuildContext context) {
    systemColors();
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            appBar: widget.appBar,
            body: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: widget.body),
            floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
            floatingActionButtonLocation: widget.floatingActionButtonLocation,
            floatingActionButton: widget.floatingActionButton,
          ),
          _fullLoading(isLoading: widget.isLoading),
        ],
      ),
    );
  }

  AnimatedSwitcher _fullLoading({required bool isLoading}) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
      child: isLoading
          ? Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Dark.card.withOpacity(.8),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                      ),
                    ),
                    height20,
                    Label(
                      "Please Wait ...",
                    ).title,
                  ],
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}

AppBar KAppBar(
  context, {
  IconData? icon,
  String? title = "title",
  Widget? child,
  bool showBack = true,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Dark.scaffold,
    automaticallyImplyLeading: false,
    titleSpacing: showBack ? 0 : kPadding,
    leadingWidth: 70,
    leading: showBack
        ? IconButton.filledTonal(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back))
        : null,
    title: child ??
        Row(
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(icon),
              ),
            Label(title!, fontSize: 22).title,
          ],
        ),
    actions: actions,
  );
}
