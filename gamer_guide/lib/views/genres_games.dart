import 'package:flutter/material.dart';
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https:${games[index].cover!.url!.replaceAll('thumb', 'cover_big')}'), //url[index]
                                fit: BoxFit.fill),
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
