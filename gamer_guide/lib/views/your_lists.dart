// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/user_lists_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import '../models/list_records_model.dart';
import '../widgets/add_list_dialog.dart';
import '../widgets/edit_list_dialog.dart';
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
            stream: UserListsServices.fetchListsRecords(widget.userId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('error');
              }
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final lists = snapshot.data;
                //print('lists are $lists');

                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: lists!.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          startActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                foregroundColor: Colors.white,
                                spacing: 10,
                                label: 'Edit',
                                icon: (Icons.edit),
                                backgroundColor: Colors.lightBlue,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                onPressed: (context) {
                                  editListDialog(
                                      context, lists[index].listName!);
                                },
                              ),
                              SlidableAction(
                                spacing: 10,
                                label: 'Delete',
                                icon: (Icons.delete),
                                backgroundColor: Colors.red,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                onPressed: (context) async {
                                  await UserListsServices.deleteList(
                                      listName: lists[index].listName!);
                                },
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: InkWell(
                              onTap: () => context
                                  .go('/listGames/${lists[index].listName}'),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  color: Colors.grey.withOpacity(0.4),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                            size: 20,
                                            weight: FontWeight.bold,
                                            text: lists[index]
                                                .listName!), //listId[index]
                                        MyText(
                                            text:
                                                'Games : ${lists[index].gameId!.length}'),
                                      ],
                                    ),
                                    const Icon(Icons.arrow_forward)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return const Center(
                    child: MyText(
                  text: 'No Comments',
                  size: 30,
                  weight: FontWeight.bold,
                ));
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
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.add_circle,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
