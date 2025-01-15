import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Components/kWidgets.dart';
import 'package:postr/Models/Courier_Model.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';

import '../../Components/KScaffold.dart';
import '../../Components/kButton.dart';
import '../../Components/kTextfield.dart';
import '../../Resources/data.dart';

class Package_UI extends StatefulWidget {
  final CourierModel masterdata;
  const Package_UI({super.key, required this.masterdata});

  @override
  State<Package_UI> createState() => _Package_UIState();
}

class _Package_UIState extends State<Package_UI> {
  final formKey = GlobalKey<FormState>();
  final weight = TextEditingController(text: "10");
  final length = TextEditingController(text: "11");
  final width = TextEditingController(text: "20");
  final height = TextEditingController(text: "12");
  final packageValue = TextEditingController(text: "1000");
  final contentType = TextEditingController();
  String packageType = "Document";
  String selectedUnit = "GM";
  bool isFragile = false;

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      appBar: AppBar(
        title: Label("1/3", color: kColor(context).primaryContainer).regular,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPadding),
          child: Form(
            key: formKey,
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KHeading(
                    title: "Package Details",
                    subtitle: "Enter details close to accurate"),
                Row(
                  children: [
                    _documentSelector(
                        icon: Icons.description_rounded, label: "Document"),
                    width10,
                    _documentSelector(
                        icon: Icons.devices_fold_outlined,
                        label: "Non-Document"),
                  ],
                ),
                if (packageType == "Document")
                  ...documentView()
                else
                  ...nonDocumentView(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: KButton(
            onPressed: () {
              final data = widget.masterdata.copyWith(
                weight: parseToDouble(weight.text),
                length: parseToDouble(length.text),
                width: parseToDouble(width.text),
                height: parseToDouble(height.text),
                packageValue: parseToDouble(packageValue.text),
                contentType: contentType.text,
                isFragile: isFragile,
              );

              if (packageType == "Non-Document" &&
                  formKey.currentState!.validate() &&
                  contentType.text.isNotEmpty) {
                context.push(
                  "/courier/schedule",
                  extra: {
                    "masterdata": data,
                  },
                );
              } else if (formKey.currentState!.validate()) {
                context.push(
                  "/courier/schedule",
                  extra: {
                    "masterdata": data,
                  },
                );
              } else {
                KSnackbar(context,
                    message: "All fields are required!", error: true);
              }
            },
            label: 'Final Checkout',
            icon: const Icon(
              Icons.arrow_right_alt_rounded,
            ),
            style: KButtonStyle.expanded,
          ),
        ),
      ),
    );
  }

  List<Widget> documentView() {
    return [
      KTextfield(
        controller: weight,
        suffix: DropdownButton<String>(
          underline: const SizedBox.shrink(),
          value: selectedUnit,
          items: <String>["KG", "GM"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedUnit = newValue!;
            });
          },
        ),
        label: 'Weight',
        keyboardType: TextInputType.number,
        hintText: 'Eg. 1, 2.6 etc',
        validator: (val) => KValidation.required(val),
      ).regular,
    ];
  }

  List<Widget> nonDocumentView() {
    return [
      KTextfield(
        controller: weight,
        suffix: DropdownButton<String>(
          underline: const SizedBox.shrink(),
          value: selectedUnit,
          items: <String>["KG", "GM"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedUnit = newValue!;
            });
          },
        ),
        label: 'Weight',
        keyboardType: TextInputType.number,
        hintText: 'Eg. 1, 2.6 etc',
        validator: (val) => KValidation.required(val),
      ).regular,
      Row(
        children: [
          Expanded(
            child: KTextfield(
              controller: length,
              label: 'Length',
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              suffix: Label("CM").regular,
              hintText: '(in cm)',
              validator: (val) => KValidation.required(val),
            ).regular,
          ),
          width10,
          Flexible(
            child: KTextfield(
              controller: height,
              label: 'Height',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              suffix: Label("CM").regular,
              keyboardType: TextInputType.number,
              hintText: '(in cm)',
              validator: (val) => KValidation.required(val),
            ).regular,
          ),
          width10,
          Flexible(
            child: KTextfield(
              controller: width,
              label: 'Width',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              suffix: Label("CM").regular,
              keyboardType: TextInputType.number,
              hintText: '(in cm)',
              validator: (val) => KValidation.required(val),
            ).regular,
          ),
        ],
      ),
      KTextfield(
        controller: packageValue,
        label: 'Package Value',
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.number,
        prefixText: "INR",
        hintText: 'Eg. 1000, 2500 etc',
        validator: (val) => KValidation.required(val),
      ).regular,
      KTextfield(
        controller: contentType,
        label: "Content Type",
        hintText: "Select Content Type",
      ).dropdown(
        errorText: contentType.text.isEmpty ? "Required!" : null,
        dropdownMenuEntries: List.generate(
          kPackageContentMap.length,
          (index) => DropdownMenuEntry(
            leadingIcon: SvgPicture.asset(
              kPackageContentMap[kPackageContentMap.keys.toList()[index]]!,
              height: 12,
            ),
            label: kPackageContentMap.keys.toList()[index],
            value: kPackageContentMap.keys.toList()[index],
          ),
        ),
        onSelected: (_) {
          setState(() {});
        },
      ),
      Row(
        spacing: 10,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label("Is Fragile?").title,
                Label("Check if the product is fragile and needs better handling by our team.")
                    .subtitle,
              ],
            ),
          ),
          Switch.adaptive(
            value: isFragile,
            onChanged: (value) {
              setState(() {
                isFragile = value;
              });
            },
          ),
        ],
      )
    ];
  }

  Widget _documentSelector({
    required String label,
    required IconData icon,
  }) {
    bool selected = packageType == label;
    return Expanded(
      child: KCard(
        radius: 15,
        onTap: () {
          setState(() {
            packageType = label;
          });
        },
        padding: const EdgeInsets.all(15),
        color: selected ? kOpacity(kColor(context).tertiary, .5) : DColor.card,
        borderWidth: 1,
        borderColor: selected ? kColor(context).tertiaryContainer : DColor.card,
        child: Row(
          children: [
            Icon(icon),
            width10,
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
