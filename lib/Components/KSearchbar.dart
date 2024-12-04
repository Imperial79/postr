import 'package:flutter/material.dart';
import 'package:postr/Components/kTextfield.dart';
import 'package:postr/Resources/colors.dart';

class KSearchbar extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onSpeechResult;
  final void Function()? onClear;

  const KSearchbar({
    super.key,
    required this.controller,
    required this.hintText,
    this.onFieldSubmitted,
    this.onClear,
    this.onSpeechResult,
  });

  @override
  State<KSearchbar> createState() => _KSearchbarState();
}

class _KSearchbarState extends State<KSearchbar> {
  @override
  Widget build(BuildContext context) {
    return KTextfield(
      controller: widget.controller,
      fontSize: 15,
      fieldColor: Dark.scaffold,
      prefix: const Icon(
        Icons.search,
        size: 25,
      ),
      hintText: widget.hintText,
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.controller.text.isNotEmpty)
            IconButton(
              onPressed: () {
                widget.controller.clear();
                widget.onClear?.call();
                setState(() {}); // Trigger re-render only when text is cleared
              },
              icon: const Icon(
                Icons.close,
                size: 22,
              ),
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
      onChanged: (_) => setState(() {}), // Reflect any changes in the field
      onFieldSubmitted: widget.onFieldSubmitted,
    ).regular;
  }
}
