import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/my_button.dart';
import 'package:flutter_application_2/widgets/text_form_field.dart';
import 'package:go_router/go_router.dart';

import '../services/user_lists_services.dart';
import 'my_text.dart';

void addlistdialog(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const MyText(text: 'ADD A LIST'),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        //titleTextStyle: TextStyle(backgroundColor: Colors.lightBlue),
        content: SizedBox(
          height: 160,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                const SizedBox(height: 30),
                const MyText(
                    text: ' List Name :',
                    paddingSize: 8,
                    weight: FontWeight.bold),
                MyTextFormField(
                  controller: nameController,
                  text: 'name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a list name';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                text: 'Submit',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // context.go('/home/1');
                    addList(listName: nameController.text);
                  }
                },
              )
            ],
          )
        ],
      );
    },
  );
}
