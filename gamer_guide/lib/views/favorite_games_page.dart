import 'package:flutter/material.dart';

import 'package:flutter_application_2/widgets/game_tabs.dart';

import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_application_2/widgets/sliver_app_bar.dart';
import 'package:go_router/go_router.dart';

class FavoriteGames extends StatefulWidget {
  final String userId;
  const FavoriteGames({super.key, required this.userId});

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
                  TabBar(
                      splashBorderRadius: borderRad,
                      labelColor: Colors.white,
                      indicatorColor: Colors.white,
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
                    child: const TabBarView(children: [
                      GameTabs(listName: 'favGames'),
                      // WishList Tab
                      GameTabs(listName: 'wishlist'),
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
