// To parse this JSON data, do
//
//     final commentsRecordsModel = commentsRecordsModelFromJson(jsonString);

import 'dart:convert';

CommentsRecordsModel commentsRecordsModelFromJson(String str) =>
    CommentsRecordsModel.fromJson(json.decode(str));

String commentsRecordsModelToJson(CommentsRecordsModel data) =>
    json.encode(data.toJson());

class CommentsRecordsModel {
  CommentsRecordsModel({
    required this.id,
    required this.commentDescription,
    required this.starsNumber,
    required this.gameId,
    required this.userId,
  });

  String id;
  String commentDescription;
  double starsNumber;
  int gameId;
  String userId;

  factory CommentsRecordsModel.fromJson(Map<String, dynamic> json) =>
      CommentsRecordsModel(
        id: json["id"],
        commentDescription: json["commentDescription"],
        starsNumber: json["starsNumber"].toDouble(),
        gameId: json["gameId"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "commentDescription": commentDescription,
        "starsNumber": starsNumber,
        "gameId": gameId,
        "userId": userId,
      };
}
