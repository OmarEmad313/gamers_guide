// To parse this JSON data, do
//
//     final commentsRecordsModel = commentsRecordsModelFromJson(jsonString);

import 'dart:convert';

CommentsRecordsModel commentsRecordsModelFromJson(String str) =>
    CommentsRecordsModel.fromJson(json.decode(str));

class CommentsRecordsModel {
  CommentsRecordsModel({
    required this.commentDescription,
    required this.starsNumber,
    required this.gameId,
    required this.userId,
  });

  String commentDescription;
  double starsNumber;
  int gameId;
  String userId;

  factory CommentsRecordsModel.fromJson(Map<String, dynamic> json) =>
      CommentsRecordsModel(
        commentDescription: json["commentDescription"],
        starsNumber: json["starsNumber"].toDouble(),
        gameId: json["gameId"],
        userId: json["userId"],
      );
}
