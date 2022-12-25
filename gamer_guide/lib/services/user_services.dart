import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';

import '../widgets/my_text.dart';

List<String> userId = [];
String username = '';

Future<String> getUserId() async {
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

void userid() async {
  userId[0] = await getUserId();
}

Future<String> getUserName() async {
  await getUserId();
  DocumentSnapshot user =
      await FirebaseFirestore.instance.collection('users').doc(userId[0]).get();

  username = user.get('name');
  return username;
}

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
