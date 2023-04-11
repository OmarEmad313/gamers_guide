import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/user_games_model.dart';
import 'package:flutter_application_2/services/api_services.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
    //searchFunction();
    //print('length is ' + searchedGames.length.toString());
    return ListView.builder(
      itemCount: searchedGames.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
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
                    CircularPercentIndicator(
                        radius: 20,
                        percent: searchedGames[index].rating != null
                            ? double.parse(
                                '0.${searchedGames[index].rating!.floor()}')
                            : 0,
                        backgroundColor: Colors.black.withOpacity(0.4),
                        animation: true,
                        linearGradient: LinearGradient(colors: [
                          Colors.purpleAccent.withOpacity(0.5),
                          Colors.deepPurple,
                        ]),
                        animationDuration: 2000,
                        center: MyText(
                            size: 12,
                            text: searchedGames[index].rating != null
                                ? '${searchedGames[index].rating!.floor()}%'
                                : '0'))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    try {
      //sleep(const Duration(seconds: 2));
      searchFunction();

      return FutureBuilder(
        builder: (context, snapshot) {},
      );
    } catch (e) {
      print(e);

      rethrow;
    }
  }

  Widget myw() {
    return ListView.builder(
      itemCount: searchedGames.isNotEmpty ? searchedGames.length - 1 : 0,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
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
                    CircularPercentIndicator(
                        radius: 20,
                        percent: searchedGames[index].rating != null
                            ? double.parse(
                                '0.${searchedGames[index].rating!.floor()}')
                            : 0,
                        backgroundColor: Colors.black.withOpacity(0.4),
                        animation: true,
                        linearGradient: LinearGradient(colors: [
                          Colors.purpleAccent.withOpacity(0.5),
                          Colors.deepPurple,
                        ]),
                        animationDuration: 2000,
                        center: MyText(
                            size: 12,
                            text: searchedGames[index].rating != null
                                ? '${searchedGames[index].rating!.floor()}%'
                                : '0'))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
