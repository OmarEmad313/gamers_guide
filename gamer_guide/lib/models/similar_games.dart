class SimilarGamesModel {
  int? id;
  String? name;
  List<int>? similarGames;

  SimilarGamesModel({this.id, this.name, this.similarGames});

  SimilarGamesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    similarGames = json['similar_games'].cast<int>();
  }
  static List<SimilarGamesModel> games(List oneGame) {
    return oneGame.map((data) {
      //print("data $data");
      return SimilarGamesModel.fromJson(data);
    }).toList();
  }
}
