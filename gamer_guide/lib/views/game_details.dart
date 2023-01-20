import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/user_services.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/game_details_model.dart';
import '../services/data_provider.dart';
import '../services/date_functions.dart';
import '../widgets/gamedetails_listview.dart';
import '../widgets/my_button.dart';
import '../widgets/my_container.dart';
import '../widgets/show_buttons_dialog.dart';

/* final userFutureProvider = FutureProvider<List<GameDetailsModel>>(
    (ref) => GameServices().getGameDetails(gameId)); */

class GameDetails extends ConsumerWidget {
  final String gameId;

  const GameDetails({super.key, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameData = ref.watch(gameDetailsProvider(gameId));
    late YoutubePlayerController controller;

    return Scaffold(
      body: gameData.when(
          data: (gameData) {
            List<GameDetailsModel> game = gameData.map((e) => e).toList();

            /* controller = YoutubePlayerController(
                initialVideoId: game[0].videos![0].videoId!,
                flags: const YoutubePlayerFlags(
                  autoPlay: true,
                  //mute: false,
                )); */
            // String myUserId = getUserId();
            return Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https:${game[0].cover?.url ?? ''}'),
                              fit: BoxFit.fill)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            color: Colors.white,
                            onPressed: () {
                              context.go('/home/0');
                            },
                            icon: const Icon(
                              Icons.arrow_circle_left,
                              size: 60,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.475),
                      child: ListView(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.6,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: MyText(
                                        text: game[0].name ?? 'No Name',
                                        paddingSize: 20,
                                        size: 36,
                                        weight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                        text:
                                            'Release Date : ${game[0].firstReleaseDate != null ? getTime(game[0].firstReleaseDate!) : null}',
                                        color: Colors.black,
                                      ),
                                      MyText(
                                        text:
                                            'Rating : ${game[0].rating != null ? game[0].rating!.floor() : null}',
                                        color: Colors.black,
                                        weight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      MyButton(
                                        text: 'Comments',
                                        onPressed: (() => context.go(
                                            '/comments/${int.parse(gameId)}/${game[0].name}')),
                                        size: 30,
                                      ),
                                      MyButton(
                                        text: 'Add',
                                        onPressed: () async {
                                          var user = await getUserId();
                                          showButtons(
                                              context: context,
                                              gameId: game[0].id.toString(),
                                              userId: user);
                                        },
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                MyContainer(
                                  text: game[0]
                                          .involvedCompanies![0]
                                          .company!
                                          .name ??
                                      'null',
                                  hintText: 'Developer',
                                  horizontalPadding: 25,
                                  verticalPadding: 5,
                                  leadingIcon:
                                      const Icon(Icons.developer_board),
                                  onTap: () {},
                                ),
                                MyContainer(
                                  text: 'Similar Games',
                                  horizontalPadding: 25,
                                  verticalPadding: 5,
                                  leadingIcon: const Icon(Icons.publish),
                                  onTap: () {
                                    context.go(
                                        '/similarGames/${int.parse(gameId)}');
                                  },
                                )
                              ], //children
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const MyText(
                                  text: 'Genres',
                                  paddingSize: 20,
                                  size: 20,
                                  weight: FontWeight.bold,
                                ),
                                HorizantalListview(
                                  game: game,
                                  isTheme: false,
                                ),
                                const MyText(
                                  text: 'Themes',
                                  paddingSize: 20,
                                  size: 20,
                                  weight: FontWeight.bold,
                                ),
                                HorizantalListview(
                                  game: game,
                                  isTheme: true,
                                ),
                                const MyText(
                                    text: 'Videos',
                                    paddingSize: 20,
                                    size: 20,
                                    weight: FontWeight.bold),
                                /*  YoutubePlayer(
                                  controller: controller,
                                  showVideoProgressIndicator: true,
                                ), */
                                const MyText(
                                    text: 'Screenshots',
                                    paddingSize: 20,
                                    size: 20,
                                    weight: FontWeight.bold),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  child: ListView.builder(
                                    itemCount: game[0].screenshots?.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https:${game[0].screenshots?[index].url}'),
                                                  fit: BoxFit.fill),
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.25),
                                      );
                                    },
                                  ),
                                ),
                                const MyText(
                                    text: 'Summary',
                                    paddingSize: 20,
                                    size: 20,
                                    weight: FontWeight.bold),
                                MyText(
                                  text: game[0].summary ?? 'No Summary',
                                  paddingSize: 20,
                                  size: 15,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                        ], //children
                      ),
                    )
                  ],
                ),
              ),
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
