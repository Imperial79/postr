import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Components/kButton.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Models/Address_Model.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';

import '../../Components/Label.dart';

class Addresses_UI extends StatefulWidget {
  const Addresses_UI({super.key});

  @override
  State<Addresses_UI> createState() => _Addresses_UIState();
}

class _Addresses_UIState extends State<Addresses_UI> {
  @override
  Widget build(BuildContext context) {
    return KScaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPadding).copyWith(bottom: 100),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 70),
                child: Center(
                  child: Column(
                    children: [
                      Label("Select an address", fontSize: 25, fontWeight: 800)
                          .title,
                      Label("or Add one", fontSize: 20, fontWeight: 200).title,
                    ],
                  ),
                ),
              ),
              Label("Recently added").regular,
              _addressCard(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: KButton(
            onPressed: () {},
            label: "Add an address",
            icon: const Icon(Icons.add),
            style: KButtonStyle.outlined,
            backgroundColor: Dark.scaffold,
            foregroundColor: kColor(context).primaryContainer,
          ),
        ),
      ),
    );
  }

  Widget _addressCard() {
    return KCard(
      onTap: () {
        final address = AddressModel(
            name: "Avishek",
            phone: "90998239",
            address: "address",
            pincode: "pincode",
            type: "Home");
        context.pop(address.toMap());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 10,
            children: [
              const Icon(Icons.home_outlined),
              Label("Home").title,
            ],
          ),
          Row(
            spacing: 10,
            children: [
              kWidth(25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height10,
                    Label("Avishek", fontWeight: 300).regular,
                    Label("+91 9093086276", fontWeight: 300).regular,
                    height5,
                    Label("Aesby More, Netaji Colony, Near Hanuman Mandir - 713201",
                            fontWeight: 300)
                        .regular,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
