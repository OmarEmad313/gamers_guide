import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/dialog_button.dart';
import 'package:flutter_application_2/widgets/text_form_field.dart';
import '../services/user_lists_services.dart';
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
          contentPadding: const EdgeInsets.only(top: 10.0),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Divider(color: Colors.black, height: 25),
                  //const SizedBox(height: 25),
                  const MyText(
                    text: ' List Name ',
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
            DialogButton(
              text: 'save',
              onTap: () {
                if (formKey.currentState!.validate()) {
                  updateList(
                      oldListName: listName, newListName: nameController.text);
                  Navigator.pop(context);
                }
              },
            ),
          ]);
    },
  );
}
