// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/similar_games.dart';
import 'package:flutter_application_2/services/game_services.dart';
import 'package:go_router/go_router.dart';

import '../models/game_cover_model.dart';

class SimilarGamess extends StatefulWidget {
  final String gameId;
  const SimilarGamess({Key? key, required this.gameId}) : super(key: key);

  @override
  State<SimilarGamess> createState() => _SimilarGamessState();
}

class _SimilarGamessState extends State<SimilarGamess> {
  List<SimilarGamesModel> similarGames = [];
  List<GameCoverModel> gamecovers = [];
  List tempList = [];
  var isLoaded = false;
  var size = 0;

  /* @override
  void didChangeDependencies() {
    getGames();
    super.didChangeDependencies();
  } */

  @override
  void initState() {
    getGames();
    super.initState();
  }

  //Future<void>
  Future<void> getGames() async {
    similarGames = await GameServices.getSimilarGames(int.parse(widget.gameId));
    //gamecovers = await GameServices.getGameCovers();
    for (var i = 0; i < similarGames[0].similarGames!.length; i++) {
      gamecovers =
          await GameServices.getGameCovers(similarGames[0].similarGames![i]);
      // print("cover $i ${gamecovers[0].cover?.url}");
      tempList.add(gamecovers[0].cover?.url);
    }
    //print("templist $tempList");
    if (similarGames.isNotEmpty && gamecovers.isNotEmpty) {
      setState(() {
        isLoaded = true;
        //print('id is  ${widget.gameId}');
      });

      //print('similar games ${similarGames[0].similarGames![0]}');
      size = similarGames[0].similarGames!.length;
      //print("size ${size}");
      //print("gameCover ${gamecovers[0].cover?.url}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoaded,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                color: Colors.white,
                onPressed: () {
                  context.go('/');
                },
                icon: const Icon(
                  Icons.arrow_circle_left,
                  size: 40,
                ),
              ),
              backgroundColor: Colors.lightBlue,
              pinned: true,
              expandedHeight: 100.0,
              // ignore: prefer_const_constructors
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Similar Games'),
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                //spaces between grids zy elpadding (horizantal)
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        // ignore: prefer_const_constructors
                        image: DecorationImage(
                            image: NetworkImage(
                                'https:${tempList[index]}'), //url[index]
                            fit: BoxFit.fill),
                      ),
                    ),
                  );
                },
                childCount: tempList.length,
              ),
            ),
          ],
        ),
      ),
      replacement: const Center(child: CircularProgressIndicator()),
    );
  }
}
