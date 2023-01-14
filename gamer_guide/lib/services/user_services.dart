import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/my_text.dart';

Future<String> getUserId() async {
  List<String> userId = [];
  await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .limit(1)
      .get()
      .then(
        (snapShot) => snapShot.docs.forEach((user) {
          userId.add(user.id);
        }),
      );

  return userId[0];
}

/* Future<String> userid() async {
  String myuserid = await getUserId();
  return myuserid;
} */

Future<String> getUserName() async {
  String username = '';
  String myuserid = await getUserId();
  DocumentSnapshot user =
      await FirebaseFirestore.instance.collection('users').doc(myuserid).get();

  username = user.get('name');
  return username;
}

Future update(
    {required String newEmail,
    required String newPass,
    required String newName}) async {
  String myuserid = await getUserId();
  await FirebaseAuth.instance.currentUser!.updateEmail(newEmail);
  await FirebaseAuth.instance.currentUser!.updatePassword(newPass);
  await FirebaseFirestore.instance.collection('users').doc(myuserid).get().then(
      (snapshot) =>
          snapshot.reference.update({'email': newEmail, 'name': newName}));
}
//  snapshot.docs[0].reference.update({'listName': newMail}));
///////////////////////////////////////

class GetUsersNames extends StatelessWidget {
  final String userId;
  const GetUsersNames({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(userId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // print(snapshot.data!.data());
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return MyText(
              text: ' ${data['name']}',
              weight: FontWeight.bold,
              style: FontStyle.italic,
              size: 16,
              paddingSize: 8,
            );
          }
          return const Text('loading');
        }));
  }
}

class GetUsersDOB extends StatelessWidget {
  final String userId;
  const GetUsersDOB({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(userId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // print(snapshot.data!.data());
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return MyText(
              text: data['DOB'] != '' ? ' ${data['DOB']}' : '',
              weight: FontWeight.bold,
              style: FontStyle.italic,
              size: 16,
              paddingSize: 8,
            );
          }
          return const Text('loading');
        }));
  }
}
