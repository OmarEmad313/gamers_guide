import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_services.dart';

//used in show button dialog
Future addFavGame(String gameId) async {
  await getUserId();
  await FirebaseFirestore.instance.collection('users').doc(userId[0]).update({
    'favGames': FieldValue.arrayUnion([gameId])
  });
}

//used in show button dialog
Future removeFavGame(String gameId) async {
  await getUserId();
  await FirebaseFirestore.instance.collection('users').doc(userId[0]).update({
    'favGames': FieldValue.arrayRemove([gameId])
  });
}

//used in show button dialog
Future addWishlistGame(String gameId) async {
  await getUserId();
  await FirebaseFirestore.instance.collection('users').doc(userId[0]).update({
    'wishlist': FieldValue.arrayUnion([gameId])
  });
}

//used in show button dialog
Future removeWishlistGame(String gameId) async {
  await getUserId();
  await FirebaseFirestore.instance.collection('users').doc(userId[0]).update({
    'wishlist': FieldValue.arrayRemove([gameId])
  }); //arrayUnion(gameId)
}

//used in favorite_games_page
Future getFavGamesIds() async {
  await getUserId();
  List<String> favGamesIds = [];
  final userInsatnce =
      await FirebaseFirestore.instance.collection('users').doc(userId[0]).get();
  Map<String, dynamic>? userData = userInsatnce.data();
  for (var gameId in userData?['favGames']) {
    favGamesIds.add(gameId);
  }
  // print(favGamesIds);
  return favGamesIds;
}
