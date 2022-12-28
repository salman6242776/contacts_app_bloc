import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String initalValue;
  final String label;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final Function validator;
  final Function toUpdate;
  const CustomTextFormField({
    super.key,
    required this.initalValue,
    required this.label,
    required this.textInputType,
    required this.textInputAction,
    required this.validator,
    required this.toUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initalValue, //contactDataModel?.name ?? "",
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: label, //"Name",
      ),
      textInputAction: textInputAction,
      validator: (value) => validator(value),
      onChanged: (value) {
        toUpdate(value);
      },
    );
  }
}
