// To parse this JSON data, do
//
//     final listsRecordsModel = listsRecordsModelFromJson(jsonString);

import 'dart:convert';

ListsRecordsModel listsRecordsModelFromJson(String str) =>
    ListsRecordsModel.fromJson(json.decode(str));

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
}
