import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/user_services.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/game_details_model.dart';
import '../services/data_provider.dart';
import '../services/date_functions.dart';
import '../widgets/Circular_progress.dart';
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
    bool video = false;

    return Scaffold(
      body: gameData.when(
          data: (gameData) {
            List<GameDetailsModel> game = gameData.map((e) => e).toList();
            if (game[0].videos?[0].videoId != null) {
              controller = YoutubePlayerController(
                  initialVideoId: game[0].videos![0].videoId!,
                  flags: const YoutubePlayerFlags(
                    autoPlay: true,
                    //mute: false,
                  ));
              video = true;
            }

            return Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https:${game[0].cover?.url?.replaceAll('thumb', 'cover_big') ?? ''}'),
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
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 48, 48, 48),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: ListView(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: MyText(
                                text: game[0].name ?? 'No Name',
                                paddingSize: 20,
                                size: 36,
                                weight: FontWeight.bold,
                              ),
                            ),
                            const Divider(
                                color: Colors.white,
                                thickness: 3,
                                indent: 20,
                                endIndent: 20),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    const MyText(
                                      text: 'Release Date : ',
                                      weight: FontWeight.bold,
                                      size: 20,
                                    ),
                                    MyText(
                                      paddingSize: 8,
                                      text: game[0].firstReleaseDate != null
                                          ? getTime(game[0].firstReleaseDate!)
                                          : 'No Date',
                                    )
                                  ]),

                                  //const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const MyText(
                                        text: 'Rating :    ',
                                        weight: FontWeight.bold,
                                        size: 20,
                                      ),
                                      CircularProgressBar(
                                        percent: game[0].rating ?? 0,
                                        time: 3000,
                                      )
                                    ],
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
                              text:
                                  game[0].involvedCompanies![0].company!.name ??
                                      'UnKnown',
                              hintText: 'Developer',
                              horizontalPadding: 25,
                              verticalPadding: 5,
                              leadingIcon: const Icon(Icons.developer_board),
                              onTap: () {},
                            ),
                            MyContainer(
                              text: 'Similar Games',
                              horizontalPadding: 25,
                              verticalPadding: 5,
                              leadingIcon: const Icon(Icons.publish),
                              onTap: () {
                                context
                                    .go('/similarGames/${int.parse(gameId)}');
                              },
                            ),
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
                            Divider(
                                color: Colors.white,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                thickness: 3,
                                indent: 20,
                                endIndent: 20),
                            Container(
                              child: video
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const MyText(
                                            text: 'Videos',
                                            paddingSize: 20,
                                            size: 20,
                                            weight: FontWeight.bold),
                                        YoutubePlayer(
                                          controller: controller,
                                          showVideoProgressIndicator: true,
                                        ),
                                      ],
                                    )
                                  : const SizedBox(height: 1),
                            ),
                            const MyText(
                                text: 'Screenshots',
                                paddingSize: 20,
                                size: 20,
                                weight: FontWeight.bold),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: ListView.builder(
                                itemCount: game[0].screenshots?.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https:${game[0].screenshots?[index].url!.replaceAll('thumb', 'screenshot_big')}'),
                                              fit: BoxFit.fill),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.35),
                                  );
                                },
                              ),
                            ),
                            const MyText(
                                text: 'Summary',
                                size: 20,
                                paddingSize: 20,
                                weight: FontWeight.bold),
                            MyText(
                              text: game[0].summary ?? 'No Summary',
                              paddingSize: 20,
                              size: 15,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ], //children
                        ),
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
