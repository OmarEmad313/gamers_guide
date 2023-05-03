// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_2/models/game_details_model.dart';
import 'package:flutter_application_2/models/recommended_games_model.dart';
import 'package:flutter_application_2/services/user_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/popular_games.dart';
import '../models/similar_games.dart';
import '../models/user_games_model.dart';

final gameProvider = Provider<GameServices>((ref) => GameServices());

class GameServices {
  static const accessToken = 'e258bfbhtkcrtwed6zi00ghv9nghlp';
  Future<List<GameDetailsModel>> getGameDetails(int id) async {
    var client = http.Client();
    var url = Uri.parse('https://api.igdb.com/v4/games');
    var headers = {
      'Client-ID': '7usxlk55pco8z3adgw7lho72zyf43p',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'text/plain',
    };
    var body =
        '''fields name,genres.name,themes.name,rating,summary,first_release_date,
    \r\ninvolved_companies.company.name,involved_companies.developer,platforms.name,
    \r\ncover.url,screenshots.url,videos.video_id;\r\nwhere id=$id ;\r\n\r\n''';

    var response = await client.post(url, headers: headers, body: body);
    var data = jsonDecode(response.body);

    List tempList = [];
    for (var v in data) {
      //print("v $v"); // varaiable v is one object
      tempList.add(v);
    }
    // print("List ${tempList}"); // varaiable tempList contain multiple objects same as data variable
    return GameDetailsModel.games(tempList);
  }

  //------------------------

  Future<List<GamesCoverModel>> populargames() async {
    // the ? mark + PopularGames is the class name from (popular_games.dart)
    var client = http.Client();
    var url = Uri.parse('https://api.igdb.com/v4/games');
    var headers = {
      'Client-ID': '7usxlk55pco8z3adgw7lho72zyf43p',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'text/plain',
    };
    var body =
        '''fields cover.url;\r\nwhere category = (0,9) & platforms = 48 & aggregated_rating>90;\r\nlimit 6;''';
    var response = await client.post(url, headers: headers, body: body);

    var data = jsonDecode(response.body);
    return GamesCoverModel.games(data);
  }

  //------------------------
  Future<List<GamesCoverModel>> newgames() async {
    var client = http.Client();
    var url = Uri.parse('https://api.igdb.com/v4/games');
    var headers = {
      'Client-ID': '7usxlk55pco8z3adgw7lho72zyf43p',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'text/plain',
    };
    var body =
        '''fields cover.url;\r\nwhere platforms = 48 & first_release_date < 1609689433 & cover.url!=null; \r\nsort first_release_date desc;\r\nlimit 6;''';
    var response = await client.post(url, headers: headers, body: body);

    var data = jsonDecode(response.body);

    return GamesCoverModel.games(data);
  }

  //------------------------

  static Future<List<SimilarGamesModel>> getSimilarGames(int id) async {
    var client = http.Client();
    var url = Uri.parse('https://api.igdb.com/v4/games');
    var headers = {
      'Client-ID': '7usxlk55pco8z3adgw7lho72zyf43p',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'text/plain',
    };
    var body =
        '''fields id,name,similar_games; where id=$id & similar_games.cover.url!=null ; ''';
    var response = await client.post(url, headers: headers, body: body);

    var data = jsonDecode(response.body);
    // print("List ${tempList}"); // varaiable tempList contain multiple objects same as data variable
    return SimilarGamesModel.games(data);
  }

  //--------------------------------
  static Future<List<GamesCoverModel>> getGameCovers(int id) async {
    var client = http.Client();
    var url = Uri.parse('https://api.igdb.com/v4/games');
    var headers = {
      'Client-ID': '7usxlk55pco8z3adgw7lho72zyf43p',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'text/plain',
    };
    var body = '''fields id,name,cover.url;\r\nwhere id=$id;\r\n''';
    var response = await client.post(url, headers: headers, body: body);

    var data = jsonDecode(response.body);
    // print("data ${data}"); // varaiable data contain multiple objects
    List tempList = [];
    for (var v in data) {
      //print("v $v"); // varaiable v is one object
      tempList.add(v);
    }
    // print("List ${tempList}"); // varaiable tempList contain multiple objects same as data variable
    return GamesCoverModel.games(tempList);
  }

  //--------------------------------
  // used in genre_games page
  Future<List<GamesCoverModel>> getGenreGameCovers(String genreName) async {
    var client = http.Client();
    var url = Uri.parse('https://api.igdb.com/v4/games');
    var headers = {
      'Client-ID': '7usxlk55pco8z3adgw7lho72zyf43p',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'text/plain',
    };
    var body = '''fields cover.url,genres.name,name;
where genres.name ="$genreName" & cover.url!=null & aggregated_rating>90; 
limit 8;''';
    var response = await client.post(url, headers: headers, body: body);

    var data = jsonDecode(response.body);
    //print("data ${data}"); // varaiable data contain multiple objects
    List tempList = [];
    for (var v in data) {
      //print("v $v"); // varaiable v is one object
      tempList.add(v);
    }
    // print("List ${tempList}"); // varaiable tempList contain multiple objects same as data variable
    return GamesCoverModel.games(tempList);
  }

  //--------------------------------
  // used in fav_games_page
  static Future<List<UserGamesModel>> getUserGames(String id) async {
    var client = http.Client();
    var url = Uri.parse('https://api.igdb.com/v4/games');
    var headers = {
      'Client-ID': '7usxlk55pco8z3adgw7lho72zyf43p',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'text/plain',
    };
    var body = '''fields name,cover.url,rating;\r\nwhere id=$id;''';
    var response = await client.post(url, headers: headers, body: body);

    var data = jsonDecode(response.body);
    return UserGamesModel.games(data);
  }

  //-------------------------------------------------------------------
  //used in userpreference page
  static Future<List<GamesCoverModel>> userPreferenceGames() async {
    var client = http.Client();
    var url = Uri.parse('https://api.igdb.com/v4/games');
    var headers = {
      'Client-ID': '7usxlk55pco8z3adgw7lho72zyf43p',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'text/plain',
    };
    var body =
        '''fields name , cover.url , first_release_date , platforms.abbreviation , rating , aggregated_rating,slug;
                where category = (0,9) & platforms = (48)  & rating>95;
                sort rating desc;
                limit 10;''';
    var response = await client.post(url, headers: headers, body: body);

    var data = jsonDecode(response.body);
    return GamesCoverModel.games(data);
  }

  //-------------------------------------------------------------------
  //used in userpreference page
  static Future<List<UserGamesModel>> gamesSearched(String gameName) async {
    var client = http.Client();
    var url = Uri.parse('https://api.igdb.com/v4/games');
    var headers = {
      'Client-ID': '7usxlk55pco8z3adgw7lho72zyf43p',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'text/plain',
    };
    var body = '''fields name , cover.url ,rating;
            search " $gameName" ;
            limit 8;''';
    var response = await client.post(url, headers: headers, body: body);

    var data = jsonDecode(response.body);
    return UserGamesModel.games(data);
  }

  //-------------------------------------------------
  Future<List<RecommendedGamesModel>> getRecommendedGames() async {
    //var idsArray = [6036, 75235, 7331];
    String myuserid = await getUserId();
    /* var test =
        await testEndpoint(endpoint: '/recommendMobile', userId: myuserid); */
    var tempList = [];

    /* int number = await FirebaseFirestore.instance
        .collection('comments')
        .where('userId', isEqualTo: myuserid)
        .snapshots()
        .length;
    print(number); */
    //---------------------------------------
    String message = '''
{
  "6036": 85,
  "7334": 0,
  "76244": 100,
  "119133": 81
}
''';
    Map<String, dynamic> gameData = jsonDecode(message);
    for (String gameId in gameData.keys) {
      int matching = gameData[gameId];

      final recommendedGamesInsatnce = FirebaseFirestore.instance
          .collection('users')
          .doc(myuserid)
          .collection('recommendedGames')
          .doc();
      final recommendedGamesData = {
        'gameId': gameId,
        'matching': matching,
      };
      await recommendedGamesInsatnce.set(recommendedGamesData);
    }
    //---------------------------------------

    List<String> userGamesIds = [];
    List<double> userMatching = [];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(myuserid)
        .collection('recommendedGames')
        .get()
        .then((value) {
      //print(value.docs.first.data()['gameId']);
      for (var doc in value.docs) {
        //print(doc.data()['gameId']);
        userGamesIds.add(doc.data()['gameId']);
        userMatching.add(doc.data()['matching'] + .0);
      }
    });
    //print(userGamesIds.length);

    var client = http.Client();
    for (var i = 0; i < userGamesIds.length; i++) {
      var body =
          '''fields name,cover.url,rating, first_release_date ; where id=${userGamesIds[i]};''';
      var response = await client.post(url, headers: headers, body: body);

      var data = jsonDecode(response.body);
      tempList.add(data[0]);
    }

    return RecommendedGamesModel.games(tempList, userMatching);
  }

  var url = Uri.parse('https://api.igdb.com/v4/games');

  var headers = {
    'Client-ID': '7usxlk55pco8z3adgw7lho72zyf43p',
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'text/plain',
  };
}

Future<void> testEndpoint({required String endpoint, String? userId}) async {
  http.Response response;
  if (endpoint == '/recommendMobile') {
    response = await http.get(
      Uri.parse('http://10.0.2.2:5000$endpoint?user_id=$userId'),
    );
  } else {
    response = await http.post(
      Uri.parse('http://10.0.2.2:5000$endpoint'),
    );
  }

  if (response.statusCode == 200) {
    var data =
        jsonDecode(response.body)['message'] ?? jsonEncode(response.body);
    print(data);

    final recommendedGamesInsatnce = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('recommendedGames')
        .doc();
    final recommendedGamesData = {
      'gameId': 'listName',
      'matching': '',
    };
    await recommendedGamesInsatnce.set(recommendedGamesData);

    return data;
  } else {
    throw Exception('Failed to load data from the endpoint');
  }
}
