class GameCoverModel {
  int? id;
  Cover? cover;
  String? name;

  GameCoverModel({this.id, this.cover, this.name});

  GameCoverModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
    name = json['name'];
  }
  static List<GameCoverModel> games(List oneGame) {
    return oneGame.map((data) {
      //print("data $data");
      return GameCoverModel.fromJson(data);
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
