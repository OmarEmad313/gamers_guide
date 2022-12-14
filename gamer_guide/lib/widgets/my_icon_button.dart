import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final double? size;
  final Color? color;
  const MyIconButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      this.size,
      this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      iconSize: size,
      color: color,
    );
  }
}
