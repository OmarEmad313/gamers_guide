import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/popular_games.dart';
import 'package:flutter_application_2/services/game_services.dart';
import 'package:go_router/go_router.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  List<PopularGamesModel> covers = [];
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    covers = await GameServices().populargames();
    /* for (var i = 1; i <= games!.length; i++) {
      covers = await GameServices().getCovers(games![i].cover!);
      url[i] = covers![i].url!;
    } */
    /* for (var element in games!) {
      covers = await GameServices().getCovers(games![element.cover!].cover!);
    } */
    if (covers.isNotEmpty) {
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
        title: const Text(
          'HomePage',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey.withOpacity(0.4),
                ),
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Popular',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: covers.length, //games!.length
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 8),
                            child: InkWell(
                              onTap: () {
                                context.go('/gamedetails/${covers[index].id}');
                              },
                              child: Container(
                                width: 100,
                                // ignore: prefer_const_constructors
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https:${covers[index].cover?.url}'), //${covers[index].cover?.url}
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey.withOpacity(0.4),
                ),
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
            )
          ],
        ),
      ),
    );
  }
}
