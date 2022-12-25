import 'package:flutter/material.dart';

import 'my_icon_button.dart';

class EditDelete extends StatelessWidget {
  const EditDelete({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyIconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
            color: Colors.lightBlue,
            size: 30,
          ),
          MyIconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            color: Colors.red,
            size: 30,
          )
        ],
      ),
    );
  }
}
