// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/user_lists_services.dart';

import 'package:go_router/go_router.dart';

import '../models/list_records_model.dart';
import '../services/user_services.dart';
import '../widgets/add_list_dialog.dart';
import '../widgets/edit_delete.dart';
import '../widgets/my_text.dart';
import '../widgets/sliver_app_bar.dart';

class YourLists extends StatefulWidget {
  final String userId;
  const YourLists({super.key, required this.userId});

  @override
  State<YourLists> createState() => _YourListsState();
}

class _YourListsState extends State<YourLists> {
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
              child: StreamBuilder<List<ListsRecordsModel>>(
            stream: fetchListsRecords(widget.userId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('error');
              }
              if (snapshot.hasData) {
                final lists = snapshot.data;
                //print('lists are $lists');
                print(userId[0]);
                return SizedBox(
                  width: 200,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: lists!.length,
                      itemBuilder: (context, index) {
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                        text: lists[index]
                                            .listName!), //listId[index]
                                    MyText(
                                        text:
                                            'Games : ${lists[index].gameId!.length}'),
                                  ],
                                ),
                                const EditDelete(),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
              //
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
