import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/models/list_records_model.dart';
import 'user_services.dart';

/* Future getListsIds() async {
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
} */

//used in add_list_dialog in your_lists
Future addList({required listName}) async {
  String myuserid = await getUserId();
  final listInsatnce = FirebaseFirestore.instance
      .collection('users')
      .doc(myuserid)
      .collection('Lists')
      .doc();
  final listData = {
    'listName': listName,
    'gameId': [],
  };
  await listInsatnce.set(listData);
}

//used in edit_delete widget in your_list page
Future deleteList({required listName}) async {
  String myuserid = await getUserId();
  await FirebaseFirestore.instance
      .collection('users')
      .doc(myuserid)
      .collection('Lists')
      .where('listName', isEqualTo: listName)
      .get()
      .then((snapshot) => snapshot.docs[0].reference.delete());
}

//used in edit_delete widget in your_list page
Future updateList({required oldListName, required newListName}) async {
  String myuserid = await getUserId();
  await FirebaseFirestore.instance
      .collection('users')
      .doc(myuserid)
      .collection('Lists')
      .where('listName', isEqualTo: oldListName)
      .get()
      .then((snapshot) =>
          snapshot.docs[0].reference.update({'listName': newListName}));
}

//used in your_lists  AND HorizontalUserLists widget
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

//used in listGames page
Future getUserListGamesIds(String listName) async {
  String myuserid = await getUserId();
  List<String> userListGamesIds = [];
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(myuserid)
      .collection('Lists')
      .where('listName', isEqualTo: listName)
      .get();

  var data = querySnapshot.docs.first.data();
  // print(data);

  for (var oneGame in data['gameId']) {
    userListGamesIds.add(oneGame);
  }
  //print(userListGamesIds);
  return userListGamesIds;
}
