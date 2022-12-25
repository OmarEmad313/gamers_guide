class UserGamesModel {
  int? id;
  Cover? cover;
  String? name;
  double? rating;

  UserGamesModel({this.id, this.cover, this.name, this.rating});

  UserGamesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
    name = json['name'];
    rating = json['rating'];
  }
  static List<UserGamesModel> games(List oneGame) {
    return oneGame.map((data) {
      //print("data $data");
      return UserGamesModel.fromJson(data);
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
