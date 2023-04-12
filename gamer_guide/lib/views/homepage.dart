import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/popular_games.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/data_provider.dart';
import '../widgets/homepage_container.dart';
import '../widgets/homepage_listview.dart';

class HomePageWidget extends ConsumerWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularGames = ref.watch(popularGamesProvider);
    return Scaffold(
      appBar: AppBar(
        title:
            const MyText(text: 'HomePage', size: 30, weight: FontWeight.bold),
        backgroundColor: Colors.deepPurple,
      ),
      body: popularGames.when(
          data: (popularGames) {
            List<GamesCoverModel> games = popularGames.map((e) => e).toList();
            return ListView(
              children: [
                HomePageContainer(
                  covers: games,
                  name: 'POPULAR ',
                  name2: 'Games',
                ),
                Consumer(
                  builder: (context, Ref, _) {
                    return Ref.watch(newGamesProvider).when(
                        data: (List<GamesCoverModel> newGames) {
                          return HomePageContainer(
                            covers: newGames,
                            name: 'LATEST ',
                            name2: 'Releases',
                          );
                        },
                        error: (error, stackTrace) => Text(error.toString()),
                        loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                  },
                ),
                const Center(
                    child: MyText(
                        text: 'Genres', size: 25, weight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(child: HomePageListview())),
                )
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
