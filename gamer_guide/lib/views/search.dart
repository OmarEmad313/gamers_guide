import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/user_games_model.dart';
import 'package:flutter_application_2/services/api_services.dart';
import 'package:flutter_application_2/views/game_details.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:lottie/lottie.dart';

import '../widgets/Circular_progress.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Widget customSearchBar = const Text('Type Your search Here');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: customSearchBar,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () =>
                  showSearch(context: context, delegate: MySearchDelegate()),
            )
          ]),
      body: Center(
        child: Lottie.network(
            'https://assets2.lottiefiles.com/packages/lf20_l5qvxwtf.json'),
      ),
    );
  }
}

////////////////////////////
class MySearchDelegate extends SearchDelegate {
  BorderRadius borderRad = const BorderRadius.all(Radius.circular(20));

  List<UserGamesModel> searchedGames = [];
  Future searchFunction() async {
    print('in search function  ->' + '$query');
    searchedGames = await GameServices.gamesSearched(query);
    print('length is ' + searchedGames.length.toString());
    for (var element in searchedGames) {
      print(element.name);
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: (() {
          query.isEmpty ? close(context, null) : query = '';
        }),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // 8alebn htb2a list of model
    List<String> matchQuery = [];
    for (var game in searchedGames) {
      if (game.name!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(game.name!);
      }
    }
    try {
      return FutureBuilder(
        future: searchFunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return myListViewBuilder();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    try {
      return FutureBuilder(
        future: searchFunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return myListViewBuilder();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Widget myListViewBuilder() {
    return ListView.builder(
      /* searchedGames.isNotEmpty ? searchedGames.length - 1 : 0, */
      itemCount: searchedGames.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameDetails(
                  gameId: searchedGames[index].id.toString(),
                ),
              ),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.175,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: borderRad,
                color: Colors.black.withOpacity(0.4),
              ),
              child: Row(
                children: [
                  searchedGames[index].cover != null
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: borderRad,
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https:${searchedGames[index].cover!.url!.replaceAll('thumb', 'cover_big')}'), /* fit: BoxFit.fill */
                            ),
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                        ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.475,
                          child: MyText(
                            text: searchedGames[index].name!,
                            paddingSize: 8,
                          )),
                      CircularProgressBar(
                        percent: searchedGames[index].rating ?? 0,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
