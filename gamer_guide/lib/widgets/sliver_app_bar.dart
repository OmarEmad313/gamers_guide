import 'package:flutter/material.dart';

class MySliverAppbar extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  final bool noBack;
  const MySliverAppbar(
      {super.key,
      required this.text,
      required this.ontap,
      required this.noBack});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: noBack
          ? null
          : IconButton(
              //color: Colors.white,
              onPressed: ontap,
              icon: const Icon(
                Icons.arrow_circle_left,
                size: 40,
              ),
            ),
      backgroundColor: Colors.deepPurple,
      pinned: true,
      expandedHeight: 150.0,
      // ignore: prefer_const_constructors
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
