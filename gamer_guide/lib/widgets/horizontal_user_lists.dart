import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/notification_api_services.dart';

import '../models/list_records_model.dart';
import '../services/user_games_services.dart';
import '../services/user_lists_services.dart';
import '../services/user_services.dart';

class HorizontalUserLists extends StatelessWidget {
  final String myUserid;
  final String gamId;
  const HorizontalUserLists(
      {super.key, required this.gamId, required this.myUserid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ListsRecordsModel>>(
      stream: UserListsServices.fetchListsRecords(myUserid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('error');
        }
        if (snapshot.hasData) {
          final lists = snapshot.data;
          //print('lists are $lists');

          return SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: lists!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () async {
                      await addGameToUserList(
                          listName: lists[index].listName!, gameId: gamId);
                      /* NotificationApi.showNotification(
                          title: 'hello', body: 'game is added', payload: ''); */
                    },
                    onLongPress: () async => await removeGameToUserList(
                        listName: lists[index].listName!, gameId: gamId),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: Text(lists[index].listName!),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
