import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/user_lists_services.dart';
import 'package:go_router/go_router.dart';

import 'edit_list_dialog.dart';
import 'my_icon_button.dart';

class EditDelete extends StatelessWidget {
  final String listName;
  const EditDelete({super.key, required this.listName});

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
            onPressed: () {
              editListDialog(context, listName);
              // print('edit');
            },
            icon: const Icon(Icons.edit),
            color: Colors.lightBlue,
            size: 30,
          ),
          MyIconButton(
            onPressed: () async {
              await UserListsServices.deleteList(listName: listName);
              //print('delete');
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
            size: 30,
          )
        ],
      ),
    );
  }
}
