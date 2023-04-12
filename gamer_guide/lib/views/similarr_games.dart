// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/similar_games.dart';
import 'package:flutter_application_2/services/api_services.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:go_router/go_router.dart';
import '../models/popular_games.dart';
import '../widgets/sliver_app_bar.dart';

class SimilarGamess extends StatefulWidget {
  final String gameId;
  const SimilarGamess({Key? key, required this.gameId}) : super(key: key);

  @override
  State<SimilarGamess> createState() => _SimilarGamessState();
}

class _SimilarGamessState extends State<SimilarGamess> {
  List<SimilarGamesModel> similarGames = [];
  List<GamesCoverModel> gamecovers = [];
  List tempList = [];
  var isLoaded = false;
  var similarGamesAvailable = true;

  @override
  void initState() {
    getGames();
    super.initState();
  }

  Future<void> getGames() async {
    similarGames = await GameServices.getSimilarGames(int.parse(widget.gameId));
    if (similarGames.isNotEmpty) {
      for (var i = 0; i < similarGames[0].similarGames!.length / 2; i++) {
        gamecovers =
            await GameServices.getGameCovers(similarGames[0].similarGames![i]);
        // print("cover $i ${gamecovers[0].cover?.url}");
        gamecovers[0].cover != null
            ? tempList.add(gamecovers[0].cover?.url)
            : null;
      }
    } else {
      setState(() => similarGamesAvailable = false);
    }
    //print("templist $tempList");
    if (gamecovers.isNotEmpty) {
      setState(() => isLoaded = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: similarGamesAvailable & isLoaded ? true : false,
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              MySliverAppbar(
                text: 'Similar Games ',
                ontap: () {
                  context.go('/gamedetails/${widget.gameId}');
                },
                noBack: false,
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                  //spaces between grids zy elpadding (horizantal)
                  childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https:${tempList[index].replaceAll('thumb', 'cover_big')}'), //url[index]
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
        replacement: Scaffold(
          body: CustomScrollView(slivers: <Widget>[
            MySliverAppbar(
              text: 'Similar Games ',
              ontap: () {
                context.go('/gamedetails/${widget.gameId}');
              },
              noBack: false,
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.4,
                    ),
                    child: similarGamesAvailable
                        ? const CircularProgressIndicator()
                        : const MyText(
                            text: 'No Similar Games Available',
                            size: 30,
                          )),
              ),
            )
          ]),
        ));
  }
}
