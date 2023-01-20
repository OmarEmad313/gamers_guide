class GamesCoverModel {
  int? id;
  Cover? cover;

  GamesCoverModel({this.id, this.cover});

  GamesCoverModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
  }

  static List<GamesCoverModel> games(List allGames) {
    return allGames.map((oneGame) {
      //print("data $data");
      return GamesCoverModel.fromJson(oneGame);
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
