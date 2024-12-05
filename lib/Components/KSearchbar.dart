import 'package:flutter/material.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';

class KSearchbar extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
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
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<KSearchbar> createState() => _KSearchbarState();
}

class _KSearchbarState extends State<KSearchbar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      cursorColor: Dark.primary,
      style: const TextStyle(),
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      decoration: InputDecoration(
          filled: true,
          fillColor: Dark.card,
          border: OutlineInputBorder(
            borderRadius: kRadius(10),
            borderSide: BorderSide.none,
          ),
          suffixIcon: const Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          suffixIconConstraints:
              const BoxConstraints(minHeight: 0, minWidth: 0),
          contentPadding: const EdgeInsets.all(20),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Dark.fadeText)),
      onChanged: (_) => setState(() {}),
    );
  }
}
