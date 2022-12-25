// To parse this JSON data, do
//
//     final listsRecordsModel = listsRecordsModelFromJson(jsonString);

import 'dart:convert';

ListsRecordsModel listsRecordsModelFromJson(String str) =>
    ListsRecordsModel.fromJson(json.decode(str));

/* String listsRecordsModelToJson(ListsRecordsModel data) =>
    json.encode(data.toJson()); */

class ListsRecordsModel {
  ListsRecordsModel({
    this.listName,
    this.gameId,
  });

  String? listName;
  List<String>? gameId;

  factory ListsRecordsModel.fromJson(Map<String, dynamic> json) =>
      ListsRecordsModel(
        listName: json["listName"],
        gameId: List<String>.from(json["gameId"].map((x) => x)),
      );

  /*  Map<String, dynamic> toJson() => {
        "listName": listName,
        "gameId": List<dynamic>.from(gameId!.map((x) => x)),
      }; */
}
