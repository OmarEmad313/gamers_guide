import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/popular_games.dart';
import 'package:flutter_application_2/services/api_services.dart';
import 'package:flutter_application_2/widgets/my_text.dart';

import '../widgets/homepage_container.dart';
import '../widgets/homepage_listview.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  HomePageWidgetState createState() => HomePageWidgetState();
}

class HomePageWidgetState extends State<HomePageWidget> {
  List<PopularGamesModel> popularGames = [];
  List<PopularGamesModel> newGames = [];
  var isLoaded = false;

  final user = FirebaseAuth.instance.currentUser!;
  //user.email

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    popularGames = await GameServices().populargames();
    newGames = await GameServices().newgames();
    /* for (var i = 1; i <= games!.length; i++) {
      covers = await GameServices().getCovers(games![i].cover!);
      url[i] = covers![i].url!;
    } */
    /* for (var element in games!) {
      covers = await GameServices().getCovers(games![element.cover!].cover!);
    } */
    if (popularGames.isNotEmpty && newGames.isNotEmpty) {
      setState(() {
        isLoaded = true;
        //print('id is ${covers[0].game.id}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const MyText(text: 'HomePage', size: 30, weight: FontWeight.bold),
        backgroundColor: Colors.deepPurple,
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView(
          children: [
            HomePageContainer(covers: popularGames, name: 'Popular'),
            HomePageContainer(covers: newGames, name: 'Latest Releases'),
            const Center(
                child:
                    MyText(text: 'Genres', size: 25, weight: FontWeight.bold)),
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
        ),
      ),
    );
  }
}
