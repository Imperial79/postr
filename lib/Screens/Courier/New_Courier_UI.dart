import 'package:flutter/material.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Resources/constants.dart';

class NewCourierUI extends StatefulWidget {
  const NewCourierUI({super.key});

  @override
  State<NewCourierUI> createState() => _NewCourierUIState();
}

class _NewCourierUIState extends State<NewCourierUI> {
  @override
  Widget build(BuildContext context) {
    return KScaffold(
      appBar: KAppBar(
        context,
        title: "Courier",
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ),
      ),
    );
  }
}
