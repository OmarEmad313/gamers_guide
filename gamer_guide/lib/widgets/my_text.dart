import 'package:flutter/cupertino.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final double paddingSize;

  const MyText(
      {super.key,
      required this.text,
      this.size,
      this.weight,
      this.color,
      required this.paddingSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingSize),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: size, fontWeight: weight),
      ),
    );
  }
}
