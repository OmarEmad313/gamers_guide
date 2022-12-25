import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/user_games_model.dart';
import 'package:flutter_application_2/services/api_services.dart';
import 'package:flutter_application_2/services/user_games_services.dart';

import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_application_2/widgets/sliver_app_bar.dart';
import 'package:go_router/go_router.dart';

import '../services/user_lists_services.dart';

class FavoriteGames extends StatefulWidget {
  final String userId;
  const FavoriteGames({super.key, required this.userId});

  @override
  State<FavoriteGames> createState() => _FavoriteGamesState();
}

class _FavoriteGamesState extends State<FavoriteGames> {
  BorderRadius borderRad = const BorderRadius.all(Radius.circular(20));
  List<UserGamesModel> userGames = [];
  List<String> favGamesIds = [];
  List tempList = [];
  @override
  void initState() {
    super.initState();
  }

  Future<void> mainFunction() async {
    favGamesIds = await getFavGamesIds();
    print(favGamesIds); //favGamesIds.length
    for (var i = 0; i < favGamesIds.length; i++) {
      print(i);
      userGames = await GameServices.getUserGames(int.parse(favGamesIds[i]));
      tempList.add(userGames[i].name);
      print('length ${tempList}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MySliverAppbar(
              text: 'Your Games',
              ontap: () {
                context.go('/home/2');
              },
              noBack: false,
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  TabBar(
                      splashBorderRadius: borderRad,
                      labelColor: Colors.black,
                      tabs: const [
                        Tab(
                          text: 'Fav',
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.deepPurple,
                          ),
                        ),
                        Tab(
                          text: 'Wishlist',
                          icon: Icon(
                            Icons.list_alt,
                            color: Colors.deepPurple,
                          ),
                        )
                      ]),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(children: [
                      // Favorite games tab
                      FutureBuilder(
                          future: mainFunction(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: borderRad,
                                        color: Colors.grey.withOpacity(0.4),
                                      ),
                                      height: 200,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 125,
                                            decoration: BoxDecoration(
                                              borderRadius: borderRad,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https:${userGames[index].cover!.url}'),
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 159,
                                                child: MyText(
                                                  text: userGames[index].name!,
                                                  paddingSize: 8,
                                                  weight: FontWeight.bold,
                                                  style: FontStyle.italic,
                                                  size: 20,
                                                ),
                                              ),
                                              MyText(
                                                text:
                                                    'Game Rating :${userGames[index].rating!.floor()}',
                                                paddingSize: 8,
                                                style: FontStyle.italic,
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                                size: 30,
                                              ),
                                              onPressed: () {},
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),

                      // WishList Tab
                      const Center(
                          child: MyText(
                        text: 'text 2',
                        paddingSize: 0,
                        size: 30,
                      ))
                    ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//////////////////////////////
