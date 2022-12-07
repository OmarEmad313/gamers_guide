import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MySliverAppbar extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  const MySliverAppbar({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        color: Colors.white,
        onPressed: ontap,
        icon: const Icon(
          Icons.arrow_circle_left,
          size: 40,
        ),
      ),
      backgroundColor: Colors.lightBlue,
      pinned: true,
      expandedHeight: 150.0,
      // ignore: prefer_const_constructors
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          text,
        ),
      ),
    );
  }
}
