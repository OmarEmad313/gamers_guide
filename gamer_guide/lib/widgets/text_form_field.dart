import 'package:flutter/material.dart';
/* reusable textformfield flutter */

class MyTextFormField extends StatelessWidget {
  final String text;
  final double? horizontalPadding;
  final double? verticalPadding;
  final FormFieldValidator<String> validator;
  final bool? secure;
  const MyTextFormField(
      {super.key,
      required this.text,
      required this.validator,
      this.horizontalPadding,
      this.verticalPadding,
      this.secure});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? 5,
            horizontal: horizontalPadding ?? 30),
        child: TextFormField(
          obscureText: secure ?? false,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0XFFD3D3D3),
            hintText: text,
            hintStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: BorderSide.none),
          ),
        ));
  }
}
