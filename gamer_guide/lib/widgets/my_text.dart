import 'package:flutter/cupertino.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final FontStyle? style;
  final Color? color;
  final double? paddingSize;
  final bool? underlined;

  const MyText(
      {super.key,
      required this.text,
      this.size,
      this.weight,
      this.color,
      this.paddingSize,
      this.style,
      this.underlined});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingSize ?? 0),
      child: Text(
        text,
        style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: weight,
            fontStyle: style ?? FontStyle.italic,
            decoration: underlined == true ? TextDecoration.underline : null,
            decorationThickness: 3),
      ),
    );
  }
}
