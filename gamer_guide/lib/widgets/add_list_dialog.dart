import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/my_button.dart';

import 'my_text.dart';

void addlistdialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const MyText(text: 'ADD A LIST', paddingSize: 0),
        //titleTextStyle: TextStyle(backgroundColor: Colors.lightBlue),
        content: SizedBox(
          height: 300,
          child: Column(
            children: [
              const SizedBox(height: 50),
              const MyText(
                  text: ' List Name :',
                  paddingSize: 8,
                  weight: FontWeight.bold),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0XFFD3D3D3),
                  hintText: 'Name',
                  hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),
              MyButton(
                text: 'Submit',
                onPressed: () {},
                color: Colors.lightBlue,
              )
            ],
          ),
        ),
      );
    },
  );
}
