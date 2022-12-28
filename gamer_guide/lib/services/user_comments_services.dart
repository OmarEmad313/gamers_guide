import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/services/user_services.dart';

import '../models/comments_records_model.dart';

Future createComment(
    {required String gameId,
    required String comment,
    required double rating}) async {
  await getUserId();
  final commentInsatnce =
      FirebaseFirestore.instance.collection('comments').doc();

  final commentData = {
    'userId': userId[0],
    'gameId': int.parse(gameId),
    'starsNumber': rating,
    'commentDescription': comment,
  };
  await commentInsatnce.set(commentData);
}

Future fetchGameComments(String gameId) async {
  var commentsRecords = await FirebaseFirestore.instance
      .collection('comments')
      .where('gameId', isEqualTo: int.parse(gameId))
      .get();

  var list = commentsRecords.docs
      .map((e) => CommentsRecordsModel(
          commentDescription: e['commentDescription'],
          starsNumber: e['starsNumber'],
          gameId: e['gameId'],
          userId: e['userId']))
      .toList();
  return list;
}

// used in your_comments page
Stream<List<CommentsRecordsModel>> fetchUserComments(String userid) {
  return FirebaseFirestore.instance
      .collection('comments')
      .where('userId', isEqualTo: userid)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => CommentsRecordsModel.fromJson(doc.data()))
          .toList());
}
