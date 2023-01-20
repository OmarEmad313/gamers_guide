import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:go_router/go_router.dart';

import '../models/user_games_model.dart';
import '../services/api_services.dart';
import '../services/user_games_services.dart';
import 'my_text.dart';

class GameTabs extends StatelessWidget {
  final String listName;
  const GameTabs({super.key, required this.listName});

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRad = const BorderRadius.all(Radius.circular(20));
    List<UserGamesModel> userGames = [];
    List<String> gamesIds = [];
    List<UserGamesModel> tempList = [];

    Future<void> mainFunction() async {
      gamesIds = await getGamesIds(whichList: listName);
      //print(favGamesIds); //favGamesIds.length
      for (var i = 0; i < gamesIds.length; i++) {
        userGames = await GameServices.getUserGames(gamesIds[i]);
        tempList.add(userGames[0]);
      }
      //print(tempList[0].id);
    }

    return FutureBuilder(
        future: mainFunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: tempList.length,
              itemBuilder: (context, index) {
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        spacing: 10,
                        label: 'Delete',
                        icon: (Icons.delete),
                        backgroundColor: Colors.red,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        onPressed: (context) async {
                          context.go('/home/2');
                          await removeGame('${tempList[index].id}', listName);
                        },
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: borderRad,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            decoration: BoxDecoration(
                              borderRadius: borderRad,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https:${tempList[index].cover!.url}'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.475,
                                child: MyText(
                                  text: tempList[index].name!,
                                  paddingSize: 8,
                                  weight: FontWeight.bold,
                                  style: FontStyle.italic,
                                  size: 20,
                                ),
                              ),
                              MyText(
                                text:
                                    'Game Rating : ${tempList[index].rating!.floor()}',
                                paddingSize: 8,
                                style: FontStyle.italic,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
