import 'package:flutter/material.dart';

import 'my_text.dart';

class DialogButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const DialogButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.0),
                  bottomRight: Radius.circular(32.0)),
            ),
            child: Center(
              child: MyText(
                text: text,
                color: Colors.white,
                weight: FontWeight.bold,
                size: 25,
              ),
            )),
      ),
    );
  }
}
