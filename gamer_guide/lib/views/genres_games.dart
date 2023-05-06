import 'package:flutter/material.dart';
import 'package:flutter_application_2/views/game_details.dart';
import 'package:flutter_application_2/widgets/my_image_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/popular_games.dart';
import '../services/data_provider.dart';
import '../widgets/sliver_app_bar.dart';

class GenreGames extends ConsumerWidget {
  final String genreId;
  final String genreName;
  const GenreGames({super.key, required this.genreId, required this.genreName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genreGames = ref.watch(genreGamesProvider(genreName));
    return Scaffold(
      body: genreGames.when(
          data: (data) {
            List<GamesCoverModel> games = data.map((e) => e).toList();
            return CustomScrollView(
              slivers: [
                MySliverAppbar(
                  text: 'Genre: \n$genreName',
                  ontap: () => context.go('/home/0'),
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
                      return InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameDetails(
                              gameId: games[index].id.toString(),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: games[index].cover != null
                              ? MyImageContainer(
                                  url: games[index].cover!.url!,
                                  isFill: true,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.width * 0.35,
                                )
                              : SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.width * 0.35,
                                ),
                        ),
                      );
                    },
                    childCount: games.length,
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
