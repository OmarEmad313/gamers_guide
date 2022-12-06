class GameDetailsModel {
  int? id;
  Cover? cover;
  int? firstReleaseDate;
  List<Genres>? genres;
  List<InvolvedCompanies>? involvedCompanies;
  String? name;
  List<Platforms>? platforms;
  double? rating;
  List<Screenshots>? screenshots;
  String? summary;
  List<Themes>? themes;
  List<Videos>? videos;

  GameDetailsModel(
      {this.id,
      this.cover,
      this.firstReleaseDate,
      this.genres,
      this.involvedCompanies,
      this.name,
      this.platforms,
      this.rating,
      this.screenshots,
      this.summary,
      this.themes,
      this.videos});

  GameDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
    firstReleaseDate = json['first_release_date'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
    if (json['involved_companies'] != null) {
      involvedCompanies = <InvolvedCompanies>[];
      json['involved_companies'].forEach((v) {
        involvedCompanies!.add(InvolvedCompanies.fromJson(v));
      });
    }
    name = json['name'];
    if (json['platforms'] != null) {
      platforms = <Platforms>[];
      json['platforms'].forEach((v) {
        platforms!.add(Platforms.fromJson(v));
      });
    }
    rating = json['rating'];
    if (json['screenshots'] != null) {
      screenshots = <Screenshots>[];
      json['screenshots'].forEach((v) {
        screenshots!.add(Screenshots.fromJson(v));
      });
    }
    summary = json['summary'];
    if (json['themes'] != null) {
      themes = <Themes>[];
      json['themes'].forEach((v) {
        themes!.add(Themes.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(Videos.fromJson(v));
      });
    }
  }

  static List<GameDetailsModel> games(List oneGame) {
    return oneGame.map((data) {
      //print("data $data");
      return GameDetailsModel.fromJson(data);
    }).toList();
  }
}
//-------------

class Cover {
  int? id;
  String? url;

  Cover({this.id, this.url});

  Cover.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

//Themes
class Themes {
  int? id;
  String? name;

  Themes({this.id, this.name});

  Themes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class InvolvedCompanies {
  int? id;
  Genres? company;
  bool? developer;

  InvolvedCompanies({this.id, this.company, this.developer});

  InvolvedCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company = json['company'] != null ? Genres.fromJson(json['company']) : null;
    developer = json['developer'];
  }
}

class Platforms {
  int? id;
  String? name;

  Platforms({this.id, this.name});

  Platforms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

//Screenshots
class Screenshots {
  int? id;
  String? url;

  Screenshots({this.id, this.url});

  Screenshots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }
}

class Videos {
  int? id;
  String? videoId;

  Videos({this.id, this.videoId});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoId = json['video_id'];
  }
}
