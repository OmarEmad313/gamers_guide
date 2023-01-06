class PopularGamesModel {
  int? id;
  Cover? cover;

  PopularGamesModel({this.id, this.cover});

  PopularGamesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
  }

  static List<PopularGamesModel> games(List oneGame) {
    return oneGame.map((data) {
      //print("data $data");
      return PopularGamesModel.fromJson(data);
    }).toList();
  }
}

class Cover {
  int? id;
  String? url;

  Cover({this.id, this.url});

  Cover.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }
}
