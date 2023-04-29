class RecommendedGamesModel {
  int? id;
  double? matching;
  Cover? cover;
  int? firstReleaseDate;
  String? name;
  double? rating;

  RecommendedGamesModel(
      {this.id,
      this.matching,
      this.cover,
      this.firstReleaseDate,
      this.name,
      this.rating});

  RecommendedGamesModel.fromJson(Map<String, dynamic> json,
      {double? matching2}) {
    id = json['id'];

    matching = matching2 ?? 0;

    cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
    firstReleaseDate = json['first_release_date'];
    name = json['name'];

    rating = json['rating'];
  }

  static List<RecommendedGamesModel> games(List oneGame, List userMatching) {
    return oneGame.map((data) {
      var index = oneGame.indexOf(data);
      return RecommendedGamesModel.fromJson(data,
          matching2: userMatching[index]);
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
