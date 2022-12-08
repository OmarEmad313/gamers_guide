// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyContainer extends StatelessWidget {
  final String text;
  final String? hintText;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? size;
  final Icon? leadingIcon;

  final VoidCallback onTap;

  const MyContainer({
    super.key,
    required this.text,
    this.hintText,
    this.horizontalPadding,
    this.verticalPadding,
    this.leadingIcon,
    required this.onTap,
    this.size,
  });

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
            title: Text(
              text,
              style: TextStyle(fontSize: size),
            ),
            subtitle: Text(hintText ?? ""),
            trailing: const Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }
}
