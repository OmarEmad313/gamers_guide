import 'package:flutter/material.dart';

import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_application_2/widgets/sliver_app_bar.dart';
import 'package:go_router/go_router.dart';

class FavoriteGames extends StatefulWidget {
  const FavoriteGames({super.key});

  @override
  State<FavoriteGames> createState() => _FavoriteGamesState();
}

class _FavoriteGamesState extends State<FavoriteGames> {
  BorderRadius borderRad = const BorderRadius.all(Radius.circular(20));
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
                  TabBar(splashBorderRadius: borderRad, tabs: const [
                    Tab(
                      text: 'Fav',
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.lightBlue,
                      ),
                    ),
                    Tab(
                      text: 'Wishlist',
                      icon: Icon(
                        Icons.list_alt,
                        color: Colors.lightBlue,
                      ),
                    )
                  ]),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(children: [
                      // Favorite games tab

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: 6,
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
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/background.jpeg'),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      SizedBox(
                                        width: 159,
                                        child: MyText(
                                          text: 'Game Nameeeeeee',
                                          paddingSize: 8,
                                          weight: FontWeight.bold,
                                          style: FontStyle.italic,
                                          size: 20,
                                        ),
                                      ),
                                      MyText(
                                        text: 'Game Rating',
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
                      ),
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
