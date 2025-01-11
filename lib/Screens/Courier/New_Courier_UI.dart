import 'package:flutter/material.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Components/kTextfield.dart';
import 'package:postr/Resources/constants.dart';

class NewCourierUI extends StatefulWidget {
  const NewCourierUI({super.key});

  @override
  State<NewCourierUI> createState() => _NewCourierUIState();
}

class _NewCourierUIState extends State<NewCourierUI> {
  final name = TextEditingController();
  final phone = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      // appBar: KAppBar(context),
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 70),
                child: Center(
                  child: Column(
                    children: [
                      Label("New Courier?", fontSize: 25, fontWeight: 800)
                          .title,
                      Label("Enter details", fontSize: 20, fontWeight: 200)
                          .title,
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Label("Pickup Details").title,
                  const Spacer(),
                  TextButton(onPressed: () {}, child: Label("Choose").regular)
                ],
              ),
              KCard(
                padding: const EdgeInsets.all(15),
                width: double.maxFinite,
                child: Column(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KTextfield(
                      controller: name,
                      label: "Name",
                      hintText: "Eg. John Doe",
                      autofillHints: [AutofillHints.name],
                    ).regular,
                    KTextfield(
                      controller: phone,
                      label: "Phone",
                      keyboardType: TextInputType.phone,
                      autofillHints: [AutofillHints.telephoneNumber],
                      hintText: "Eg. 909××××199",
                      prefixText: "+91",
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          setState(() {
                            phone.text = val.replaceAll("+91", "");
                          });
                        }
                      },
                    ).regular,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
