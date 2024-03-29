import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/user_games_model.dart';
import 'package:flutter_application_2/services/api_services.dart';
import 'package:flutter_application_2/services/data_provider.dart';
import 'package:flutter_application_2/services/user_games_services.dart';
import 'package:flutter_application_2/services/user_services.dart';
import 'package:flutter_application_2/views/comments.dart';
import 'package:flutter_application_2/views/game_details.dart';
import 'package:flutter_application_2/widgets/circular_progress.dart';
import 'package:flutter_application_2/widgets/my_button.dart';
import 'package:flutter_application_2/widgets/my_image_container.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_application_2/widgets/show_buttons_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecommendedGames2 extends StatefulWidget {
  const RecommendedGames2({super.key});

  @override
  State<RecommendedGames2> createState() => _RecommendedGamesState();
}

class _RecommendedGamesState extends State<RecommendedGames2> {
  BorderRadius borderRad = const BorderRadius.all(Radius.circular(20));
  List<UserGamesModel> userGames = [];
  List<String> gamesIds = [];
  List<UserGamesModel> tempList = [];

  Future<void> mainFunction() async {
    gamesIds = await getGamesIds(whichList: 'favGames');
    //print(favGamesIds); //favGamesIds.length
    for (var i = 0; i < gamesIds.length; i++) {
      userGames = await GameServices.getUserGames(gamesIds[i]);
      tempList.add(userGames[0]);
    }
    //print(tempList[0].id);
  }

  @override
  Widget build(BuildContext context) {
    //final gameData = ref.watch(recommendedGamesProvider);
    return Scaffold(
      appBar: AppBar(
          title: const MyText(
        text: 'Recommended Games',
      )),
      body: FutureBuilder(
          future: mainFunction(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: tempList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameDetails(
                                gameId: tempList[index].id.toString(),
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
                                    tempList[index].cover != null
                                        ? MyImageContainer(
                                            url: tempList[index].cover!.url!,
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
                                    const MyText(text: '20/5/2001')
                                  ],
                                ),
                                Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.475,
                                      /* height: MediaQuery.of(context).size.height *
                                          0.1, */
                                      child: MyText(
                                        text: tempList[index].name!,
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
                                            percent:
                                                tempList[index].rating ?? 0,
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
                                            percent:
                                                tempList[index].rating ?? 0,
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
                                                    gameId: tempList[index]
                                                        .id
                                                        .toString(),
                                                    gameName:
                                                        tempList[index].name!),
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
                                                  tempList[index].id.toString(),
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
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
