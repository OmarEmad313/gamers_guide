import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyImageContainer extends StatelessWidget {
  final double width;
  final double? height;
  final String url;
  final bool isFill;

  const MyImageContainer({
    super.key,
    required this.width,
    required this.url,
    required this.isFill,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? null,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
            image:
                NetworkImage('https:${url.replaceAll('thumb', 'cover_big')}'),
            fit: isFill ? BoxFit.fill : null),
      ),
    );
  }
}
