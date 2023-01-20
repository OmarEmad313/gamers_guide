import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user_games_model.dart';
import '../widgets/my_text.dart';
import 'api_services.dart';
import 'user_services.dart';

//used in show button dialog
Future addGame(String gameId, String listName) async {
  String myuserid = await getUserId();
  await FirebaseFirestore.instance.collection('users').doc(myuserid).update({
    listName: FieldValue.arrayUnion([gameId])
  });
}

//used in show button dialog
Future removeGame(String gameId, String listName) async {
  String myuserid = await getUserId();
  await FirebaseFirestore.instance.collection('users').doc(myuserid).update({
    listName: FieldValue.arrayRemove([gameId])
  });
}

//used in horizontal_user_lists in show button dialog
Future addGameToUserList(
    {required String listName, required String gameId}) async {
  String myuserid = await getUserId();
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(myuserid)
      .collection('Lists')
      .where('listName', isEqualTo: listName)
      .get();
  querySnapshot.docs.first.reference.update({
    'gameId': FieldValue.arrayUnion([gameId])
  });
}

//used in horizontal_user_lists in show button dialog
Future removeGameToUserList(
    {required String listName, required String gameId}) async {
  String myuserid = await getUserId();
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(myuserid)
      .collection('Lists')
      .where('listName', isEqualTo: listName)
      .get();
  querySnapshot.docs.first.reference.update({
    'gameId': FieldValue.arrayRemove([gameId])
  });
}

//used in game_tabs widget in favorite_games_page
Future getGamesIds({required String whichList}) async {
  String myuserid = await getUserId();
  List<String> gamesIds = [];
  final userInsatnce =
      await FirebaseFirestore.instance.collection('users').doc(myuserid).get();
  Map<String, dynamic>? userData = userInsatnce.data();
  //print('userdata $userData');
  for (var gameId in userData?[whichList]) {
    gamesIds.add(gameId);
  }
  // print(favGamesIds);
  return gamesIds;
}

//used in your_comments page--------------------------------
class GetGameName extends StatelessWidget {
  final String gameId;
  const GetGameName({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserGamesModel>>(
        future: GameServices.getUserGames(gameId),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // print(snapshot.data!.data());

            // snapshot.data![0].name;
            return MyText(
              text: ' ${snapshot.data![0].name}',
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
