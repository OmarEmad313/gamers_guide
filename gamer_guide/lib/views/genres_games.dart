import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/user_services.dart';

import 'package:go_router/go_router.dart';

import '../models/game_cover_model.dart';
import '../services/api_services.dart';
import '../services/user_lists_services.dart';
import '../widgets/list_games_replacment.dart';
import '../widgets/sliver_app_bar.dart';

class GenreGames extends StatefulWidget {
  final String genreId;
  final String genreName;
  const GenreGames({super.key, required this.genreId, required this.genreName});

  @override
  State<GenreGames> createState() => _GenreGamesState();
}

class _GenreGamesState extends State<GenreGames> {
  List<GameCoverModel> gamecovers = [];
  bool isloaded = false;

  @override
  void initState() {
    mainFunction();
    super.initState();
  }

  Future<void> mainFunction() async {
    gamecovers = await GameServices.getGenreGameCovers(widget.genreName);
    //print(tempList[0]);
    if (gamecovers.isNotEmpty) {
      setState(() {
        isloaded = true;
        //  print('length is ${gamecovers.length}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isloaded,
      replacement: const Center(child: CircularProgressIndicator()),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MySliverAppbar(
              text: 'Genre: \n${widget.genreName}',
              ontap: () => context.go('/home/0'),
              noBack: false,
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
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https:${gamecovers[index].cover!.url}'), //url[index]
                            fit: BoxFit.fill),
                      ),
                    ),
                  );
                },
                childCount: gamecovers.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
