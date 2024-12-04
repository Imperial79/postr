import 'package:flutter/material.dart';
import 'package:postr/Components/KNavigationBar.dart';
import 'package:postr/Screens/Home/HomeUI.dart';

class RootUI extends StatefulWidget {
  const RootUI({super.key});

  @override
  State<RootUI> createState() => _RootUIState();
}

class _RootUIState extends State<RootUI> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeUI(),
      bottomNavigationBar: KNavigationBar(),
    );
  }
}
