import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/services/user_services.dart';

import '../models/comments_records_model.dart';

Future createComment(
    {required String gameId,
    required String comment,
    required double rating}) async {
  String myuserid = await getUserId();
  final comment2 = await FirebaseFirestore.instance
      .collection('comments')
      .where('userId', isEqualTo: myuserid)
      .where('gameId', isEqualTo: int.parse(gameId))
      .get();
  // If a comment already exists -> update it
  if (comment2.docs.isNotEmpty) {
    await comment2.docs[0].reference.update({
      'starsNumber': rating,
      'commentDescription': comment,
    });
  }
  // If the comment doesn't exists -> create it
  else {
    print('in else');
    final commentInsatnce =
        FirebaseFirestore.instance.collection('comments').doc();

    final commentData = {
      'userId': myuserid,
      'gameId': int.parse(gameId),
      'starsNumber': rating,
      'commentDescription': comment,
    };

    await commentInsatnce.set(commentData);
  }
}
///////////////////////////////////////////////////

Future updateComment({
  required gameRating,
  required gameComment,
  required gameId,
}) async {
  String myuserid = await getUserId();
  final comment2 = await FirebaseFirestore.instance
      .collection('comments')
      .where('userId', isEqualTo: myuserid)
      .where('gameId', isEqualTo: gameId)
      .get();
  await comment2.docs[0].reference.update({
    'starsNumber': gameRating,
    'commentDescription': gameComment,
  });
}
///////////////////////////////////////////////////

//used in user preference page
Future addUserPreference({
  required game,
  required gameRating,
}) async {
  String myuserid = await getUserId();
  final userPreferenceInsatnce =
      FirebaseFirestore.instance.collection('comments').doc();

  final userPreferenceData = {
    'gameId': game,
    'starsNumber': gameRating,
    'userId': myuserid,
    'commentDescription': ''
  };
  await userPreferenceInsatnce.set(userPreferenceData);
}

// used in comments page
Stream<List<CommentsRecordsModel>> fetchGameComments(String gameId) {
  final temp = FirebaseFirestore.instance
      .collection('comments')
      .where('commentDescription', isNotEqualTo: "")
      .where('gameId', isEqualTo: int.parse(gameId))
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => CommentsRecordsModel(
              commentDescription: doc['commentDescription'],
              starsNumber: doc['starsNumber'],
              gameId: doc['gameId'],
              userId: doc['userId']))
          .toList());
  //print(temp.first);
  return temp;
}

// used in your_comments page
Stream<List<CommentsRecordsModel>> fetchUserComments(String userid) {
  return FirebaseFirestore.instance
      .collection('comments')
      .where('commentDescription', isNotEqualTo: "")
      .where('userId', isEqualTo: userid)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => CommentsRecordsModel.fromJson(doc.data()))
          .toList());
}

Future deleteComment({required gameId}) async {
  String myuserid = await getUserId();
  await FirebaseFirestore.instance
      .collection('comments')
      .where('userId', isEqualTo: myuserid)
      .where('gameId', isEqualTo: gameId)
      .limit(1)
      .get()
      .then((snapshot) => snapshot.docs[0].reference.delete());
}
