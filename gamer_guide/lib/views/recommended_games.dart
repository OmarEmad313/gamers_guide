import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_2/models/recommended_games_model.dart';
import 'package:flutter_application_2/services/data_provider.dart';
import 'package:flutter_application_2/services/date_functions.dart';
import 'package:flutter_application_2/services/user_services.dart';
import 'package:flutter_application_2/views/comments.dart';
import 'package:flutter_application_2/views/game_details.dart';
import 'package:flutter_application_2/widgets/circular_progress.dart';
import 'package:flutter_application_2/widgets/my_button.dart';
import 'package:flutter_application_2/widgets/my_image_container.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_application_2/widgets/show_buttons_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecommendedGames extends ConsumerWidget {
  const RecommendedGames({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameData = ref.watch(recommendedGamesProvider);
    BorderRadius borderRad = const BorderRadius.all(Radius.circular(20));

    return Scaffold(
      appBar: AppBar(
          title: const MyText(
        text: 'Recommended Games',
      )),
      body: gameData.when(
          data: (data) {
            List<RecommendedGamesModel> games = data.map((e) => e).toList();

            //print(games[1].matching);
            if (games.isNotEmpty) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameDetails(
                                gameId: games[index].id.toString(),
                              ),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            height: MediaQuery.of(context).size.height * 0.35,
                            decoration: BoxDecoration(
                              borderRadius: borderRad,
                              color: Colors.black.withOpacity(0.4),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    games[index].cover != null
                                        ? MyImageContainer(
                                            url: games[index].cover!.url!,
                                            isFill: true,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                          )
                                        : SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                          ),
                                    MyText(
                                      text: games[index].firstReleaseDate !=
                                              null
                                          ? getTime(
                                              games[index].firstReleaseDate!)
                                          : 'No Date',
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      child: MyText(
                                        text: games[index].name!,
                                        paddingSize: 8,
                                        weight: FontWeight.bold,
                                        style: FontStyle.italic,
                                        size: 20,
                                      ),
                                    ),
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          const MyText(
                                            text: 'Rating :',
                                            paddingSize: 8,
                                            style: FontStyle.italic,
                                          ),
                                          CircularProgressBar(
                                            percent: games[index].rating ?? 0,
                                          ),
                                          const VerticalDivider(
                                            thickness: 2,
                                            width: 20,
                                            color: Colors.grey,
                                            indent: 5,
                                            endIndent: 5,
                                          ),
                                          const MyText(
                                            text: 'Matching :',
                                            style: FontStyle.italic,
                                          ),
                                          CircularProgressBar(
                                            percent: games[index].matching ?? 0,
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MyButton(
                                          text: 'Comments',
                                          onPressed: (() {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Comments(
                                                    gameId: games[index]
                                                        .id
                                                        .toString(),
                                                    gameName:
                                                        games[index].name!),
                                              ),
                                            );
                                          }),
                                          size: 10,
                                          horizontalPadding: 10,
                                        ),
                                        MyButton(
                                          text: 'Add',
                                          size: 10,
                                          horizontalPadding: 8,
                                          onPressed: () async {
                                            var user = await getUserId();
                                            showButtons(
                                              context: context,
                                              userId: user,
                                              gameId:
                                                  games[index].id.toString(),
                                            );
                                          },
                                        ),
                                        const Icon(Icons.arrow_forward),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ));
            } else {
              //int number = getNumber();
              return Consumer(
                builder: (context, ref, child) {
                  return ref.watch(ratedGamesNum).when(
                      data: (int num) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const MyText(
                                text: 'Continue Rating Games',
                                size: 20,
                                weight: FontWeight.bold,
                                paddingSize: 15,
                              ),
                              MyText(text: 'Games Rated : $num / 10'),
                            ],
                          ),
                        );
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => const Center(
                              child: MyText(
                            text: 'Continue Rating Games',
                            size: 20,
                            weight: FontWeight.bold,
                          )));
                },
              );
            }
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}

Future<int> getNumber() async {
  String myuserid = await getUserId();
  int number = await FirebaseFirestore.instance
      .collection('comments')
      .where('userId', isEqualTo: myuserid)
      .snapshots()
      .length;
  number = 4;
  print(number);

  return number;
}
