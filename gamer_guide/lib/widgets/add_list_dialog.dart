import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        //titleTextStyle: TextStyle(backgroundColor: Colors.lightBlue),
        content: SizedBox(
          height: 300,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
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
                const SizedBox(height: 20),
                MyButton(
                  text: 'Submit',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.go('/home/1');
                      addList(listname: nameController.text);
                    }
                  },
                  color: Colors.lightBlue,
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
