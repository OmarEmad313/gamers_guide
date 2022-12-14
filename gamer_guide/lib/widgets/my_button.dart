import 'package:flutter/material.dart';

import 'my_text.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final double? size;
  const MyButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.color,
      this.size});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ))),
      child: MyText(
        text: text,
        size: size ?? 20,
        style: FontStyle.italic,
        weight: FontWeight.bold,
        paddingSize: 0,
        color: Colors.white,
      ),
    );
  }
}
