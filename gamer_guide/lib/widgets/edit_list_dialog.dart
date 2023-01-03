import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/text_form_field.dart';
import 'package:go_router/go_router.dart';

import '../services/user_lists_services.dart';
import 'my_button.dart';
import 'my_text.dart';

void editListDialog(BuildContext context, String listName) {
  final TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          title: const MyText(text: 'Edit the LIST'),
          //titleTextStyle: TextStyle(backgroundColor: Colors.lightBlue),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: SizedBox(
            height: 170,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Divider(color: Colors.black),
                  const SizedBox(height: 25),
                  const MyText(
                    text: ' List Name :',
                    weight: FontWeight.bold,
                    paddingSize: 8,
                  ),
                  MyTextFormField(
                    controller: nameController,
                    text: listName,
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
            Center(
              child: InkWell(
                onTap: (() {
                  if (formKey.currentState!.validate()) {
                    updateList(
                        oldListName: listName,
                        newListName: nameController.text);
                  }
                }),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0)),
                    ),
                    child: const Center(
                      child: MyText(
                        text: 'save',
                        color: Colors.white,
                        weight: FontWeight.bold,
                        size: 25,
                      ),
                    )),
              ),
            ),
            /* MyButton(
              text: 'Save',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  updateList(
                      oldListName: listName, newListName: nameController.text);
                }
              },
            ) */
          ]);
    },
  );
}
