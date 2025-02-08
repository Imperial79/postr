import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Components/Pill.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/constants.dart';
import '../../Components/Label.dart';

class Order_Detail_UI extends ConsumerStatefulWidget {
  final int orderId;
  const Order_Detail_UI({
    super.key,
    required this.orderId,
  });

  @override
  ConsumerState<Order_Detail_UI> createState() => _Order_Detail_UIState();
}

class _Order_Detail_UIState extends ConsumerState<Order_Detail_UI> {
  final ScrollController _scrollController = ScrollController();
  final _isPastPendingLabel = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final RenderBox renderBox =
        _pendingLabelKey.currentContext?.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero).dy;
    if (position < 0 && !_isPastPendingLabel.value) {
      _isPastPendingLabel.value = true;
    } else if (position >= 0 && _isPastPendingLabel.value) {
      _isPastPendingLabel.value = false;
    }
  }

  final GlobalKey _pendingLabelKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: _isPastPendingLabel,
          builder: (context, isVisible, child) => isVisible
              ? Label("Order #${widget.orderId}").regular
              : const SizedBox(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 70),
                child: Center(
                  child: Column(
                    key: _pendingLabelKey,
                    children: [
                      Label("Order #${widget.orderId}",
                              fontSize: 25, weight: 650)
                          .title,
                      Pill(
                        backgroundColor: kOpacity(StatusText.warning, .1),
                        textColor: StatusText.warning,
                        label: "Pending",
                        fontSize: 20,
                      ).text,
                    ],
                  ),
                ),
              ),
              ...List.generate(
                100,
                (index) => Label("text").regular,
              )
            ],
          ),
        ),
      ),
    );
  }
}
