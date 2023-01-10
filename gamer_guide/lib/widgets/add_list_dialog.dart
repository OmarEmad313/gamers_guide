import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/my_button.dart';
import 'package:flutter_application_2/widgets/text_form_field.dart';

import '../services/user_lists_services.dart';
import 'dialog_button.dart';
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
          height: MediaQuery.of(context).size.height * 0.2,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Divider(color: Colors.black, height: 30),
                //const SizedBox(height: 30),
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
          DialogButton(
            text: 'Add',
            onTap: () {
              if (formKey.currentState!.validate()) {
                addList(listName: nameController.text);
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}
