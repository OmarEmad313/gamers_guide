// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/my_icon_button.dart';

import 'package:go_router/go_router.dart';

import '../widgets/add_list_dialog.dart';
import '../widgets/my_text.dart';
import '../widgets/sliver_app_bar.dart';

class YourLists extends StatefulWidget {
  const YourLists({super.key});

  @override
  State<YourLists> createState() => _YourListsState();
}

class _YourListsState extends State<YourLists> {
  List<String> listId = [];

  Future getLists() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(value.docs[0].id)
          .collection('Lists')
          .get()
          .then(
            (snapShot) => snapShot.docs.forEach((list) {
              // print(' testing ${list.id}');
              listId.add(list.reference.id);
            }),
          );
    });
  }

  @override
  void initState() {
    getLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MySliverAppbar(
            text: 'Your Lists',
            ontap: () => context.go('/home/1'),
            noBack: false,
          ),
          SliverToBoxAdapter(
            child: Expanded(
              child: FutureBuilder(
                future: getLists(),
                builder: (context, snapshot) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: Colors.grey.withOpacity(0.4),
                              ),
                              height: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      MyText(
                                        paddingSize: 0,
                                        text: 'List Name',
                                        weight: FontWeight.bold,
                                        style: FontStyle.italic,
                                        size: 20,
                                      ),
                                      MyText(text: 'Games : 5', paddingSize: 0),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Colors.white,
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyIconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.edit),
                                          color: Colors.lightBlue,
                                          size: 30,
                                        ),
                                        MyIconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.delete),
                                          color: Colors.red,
                                          size: 30,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addlistdialog(context);
        },
        backgroundColor: Colors.lightBlue,
        child: const Icon(
          Icons.add_circle,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
