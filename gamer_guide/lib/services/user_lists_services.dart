import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/list_records_model.dart';

import '../widgets/my_text.dart';
import 'user_services.dart';

Future getListsIds() async {
  await getUserId();
  List<String> listId2 = [];
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId[0]) // 96604581
      .collection('Lists')
      .get()
      .then(
        (snapShot) => snapShot.docs.forEach((list) {
          // print(' testing ${list.id}');
          listId2.add(list.id);
          //print(listId.length);
        }),
      );
  return listId2;
}

//used in add_list_dialog in your_lists
Future addList({required listname}) async {
  await getUserId();
  final listInsatnce = FirebaseFirestore.instance
      .collection('users')
      .doc(userId[0])
      .collection('Lists')
      .doc();
  final listData = {
    'listName': listname,
    'gameId': [],
  };
  await listInsatnce.set(listData);
}
/* 
Future fetchListsRecords() async {
  await getUserId();
  var listsRecords = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId[0])
      .collection('Lists')
      .get();

  var list = listsRecords.docs
      .map((e) => ListsRecordsModel(
            listName: e['listName'],
            gameId: e['gameId'],
          ))
      .toList();
  return list;
} */

//used in your_lists
Stream<List<ListsRecordsModel>> fetchListsRecords(String userid) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(userid)
      .collection('Lists')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => ListsRecordsModel.fromJson(doc.data()))
          .toList());
}



/////////////////////////////////////////////

/* class GetListName extends StatelessWidget {
  final String listId;

  const GetListName({super.key, required this.listId});

  @override
  Widget build(BuildContext context) {
    userid();
    // print('user id is ${userId[0]}');
    CollectionReference lists = FirebaseFirestore.instance
        .collection('users')
        .doc(userId[0])
        .collection('Lists');

    return FutureBuilder<DocumentSnapshot>(
        future: lists.doc(listId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // print(snapshot.data!.data());
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return MyText(
              text: ' ${data['listName']}', //${data['listName']}
              weight: FontWeight.bold,
              style: FontStyle.italic,
              size: 20,
            );
          }
          return const Text('loading');
        }));
  }
}
 */