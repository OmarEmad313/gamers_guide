import 'package:flutter/material.dart';

import 'my_text.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final double? size;
  final double? horizontalPadding;
  final double? verticalPadding;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.size,
    this.horizontalPadding,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 0, vertical: verticalPadding ?? 0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            backgroundColor:
                MaterialStateProperty.all(color /*  Colors.lightBlue */),
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
          //color: Colors.white,
        ),
      ),
    );
  }
}
