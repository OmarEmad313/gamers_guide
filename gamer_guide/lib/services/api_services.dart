// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  static const accessToken = 't5xiuzx1agiscerqcfxtxzjsp6gof1';

  static var client = http.Client();

  static var url = Uri.parse('https://api.igdb.com/v4/games');

  static var headers = {
    'Client-ID': '7usxlk55pco8z3adgw7lho72zyf43p',
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'text/plain',
  };

  Future<List<GameDetailsModel>> getGameDetails(int id) async {
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
    var body =
        '''fields cover.url;\r\nwhere category = (0,9) & platforms = 48 & aggregated_rating>90;\r\nlimit 6;''';
    var response = await client.post(url, headers: headers, body: body);

    var data = jsonDecode(response.body);
    return GamesCoverModel.games(data);
  }

  //------------------------
  Future<List<GamesCoverModel>> newgames() async {
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
    var body = '''fields cover.url,genres.name,name;
    where genres.name ="$genreName" & cover.url!=null & aggregated_rating>90; 
    limit 8;''';
    var response = await client.post(url, headers: headers, body: body);

    var data = jsonDecode(response.body);
    return GamesCoverModel.games(data);
  }

  //--------------------------------
  // used in fav_games_page
  static Future<List<UserGamesModel>> getUserGames(String id) async {
    var body = '''fields name,cover.url,rating;\r\nwhere id=$id;''';
    var response = await client.post(url, headers: headers, body: body);

    var data = jsonDecode(response.body);
    return UserGamesModel.games(data);
  }

  //-------------------------------------------------------------------
  //used in userpreference page
  static Future<List<GamesCoverModel>> userPreferenceGames() async {
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
  //used in search page
  static Future<List<UserGamesModel>> gamesSearched(String gameName) async {
    var body = '''fields name , cover.url ,rating;
            search " $gameName" ;
            limit 8;''';
    var response = await client.post(url, headers: headers, body: body);

    var data = jsonDecode(response.body);
    return UserGamesModel.games(data);
  }

  //-------------------------------------------------
  Future<List<RecommendedGamesModel>> getRecommendedGames() async {
    String myuserid = await getUserId();
    var tempList = [];
    List<String> userGamesIds = [];
    List<double> userMatching = [];
    /* var test =
        await testEndpoint(endpoint: '/recommendMobile', userId: myuserid); */

    int num = await getNumber();
    num = 10;
    if (num >= 10 || num % 5 == 0) {
      //flaskEndpoint(endpoint: '/retrainMobile');
      flaskEndpoint(endpoint: '/recommendMobile', userId: myuserid);
    }

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
    for (var i = 0; i < userGamesIds.length; i++) {
      var body =
          '''fields name,cover.url,rating, first_release_date ; where id=${userGamesIds[i]};''';
      var response = await client.post(url, headers: headers, body: body);

      var data = jsonDecode(response.body);
      tempList.add(data[0]);
    }
    return RecommendedGamesModel.games(tempList, userMatching);
  }

  Future<int> getNumber() async {
    String myuserid = await getUserId();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('comments')
        .where('userId', isEqualTo: myuserid)
        .get();

    int num = snapshot.size;
    return num;
  }
}

Future<void> flaskEndpoint({required String endpoint, String? userId}) async {
  http.Response response;
  /* if (endpoint == '/recommendMobile') {
    response = await http.get(
      Uri.parse('http://10.0.2.2:5000$endpoint?user_id=$userId'),
    );
  } else {
    response = await http.post(
      Uri.parse('http://10.0.2.2:5000$endpoint'),
    );
  } */

  if (true) {
    /* response.statusCode == 200 */
    //var data = response.body;
    // print(data);
    String message = '''
    {
      "6036": 85,
      "7334": 0
    }
    ''';
    Map<String, dynamic> gameData = jsonDecode(message);
    for (String gameId in gameData.keys) {
      int matching = gameData[gameId];

      final collectionRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('recommendedGames');
      QuerySnapshot querySnapshot =
          await collectionRef.where('gameId', isEqualTo: gameId).get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update({'matching': matching});
        print('in if');
      } else {
        print('in else');
        final recommendedGamesData = {
          'gameId': gameId,
          'matching': matching,
        };
        await collectionRef.doc('tsting2').set(recommendedGamesData);
      }
    }
  } else {
    throw Exception('Failed to load data from the endpoint');
  }
}
