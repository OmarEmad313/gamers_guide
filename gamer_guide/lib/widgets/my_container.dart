// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyContainer extends StatelessWidget {
  final String text;
  final String? hintText;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Icon? leadingIcon;
  final Icon? trailingIcon;
  final VoidCallback onTap;

  const MyContainer(
      {super.key,
      required this.text,
      this.hintText,
      this.horizontalPadding,
      this.verticalPadding,
      this.leadingIcon,
      this.trailingIcon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 0,
          vertical: verticalPadding ?? 0), //horizontal: 25, vertical: 5
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.grey.withOpacity(0.4),
          ),
          child: ListTile(
            dense: true,
            leading: leadingIcon,
            title: Text(text),
            subtitle: Text(hintText ?? ""),
            trailing: trailingIcon,
          ),
        ),
      ),
    );
  }
}
