// ignore_for_file: unused_field

/* import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart'; */
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/game_details_model.dart';
import 'package:flutter_application_2/services/game_services.dart';
import 'package:flutter_application_2/widgets/my_container.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GameDetails extends StatefulWidget {
  final String gameId;
  const GameDetails({Key? key, required this.gameId}) : super(key: key);

  @override
  State<GameDetails> createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails> {
  List<GameDetailsModel> game = [];
  var isLoaded = false;
  final videoUrl = "https://www.youtube.com/watch?v=YMx8Bbev6T4";
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          //mute: false,
        ));
    super.initState();
    getData();
  }

  Future<void> getData() async {
    game = await GameServices().getGameDetails(int.parse(widget.gameId));

    if (game.isNotEmpty) {
      setState(() {
        isLoaded = true;
      });
      //print('screenshots ${game[0].screenshots![0].url}');

    }
  }

/* 
  v {id: 6036, cover: {id: 218456, url: //images.igdb.com/igdb/image/upload/t_thumb/co4ok8.jpg}, 
  first_release_date: 1406592000,  name: The Last of Us Remastered,  rating: 94.25284051156771,
  genres: [{id: 5, name: Shooter}, {id: 31, name: Adventure}],
  involved_companies: [{id: 22266, company: {id: 401, name: Naughty Dog}, developer: true}, {id: 180645, company: {id: 13634, name: Sony Computer Entertainment}, developer: false}],
  platforms: [{id: 48, name: PlayStation 4}],
  screenshots: [{id: 9463, url: //images.igdb.com/igdb/image/upload/t_thumb/wdzisarwedjsqeg5iah4.jpg}, {id: 9464, url: //images.igdb.com/igdb/image/upload/t_thumb/oz4rxwu528bmckp1qqzt.jpg}, {id: 9465, url: //images.igdb.com/igdb/image/upload/t_thumb/d64boffz2tkso1cuj1lk.jpg}, {id: 9466, url: //images.igdb.com/igdb/image/upload/t_thumb/lqz37tmv2r4lcjaxczwx.jpg}, {id: 9467, url: //images.igdb.com/igdb/image/upload/t_thumb/iqzfweidhwepz0bf4fhr.jpg}],
  summary: The Last of Us has been remastered for the PlayStation 4. Now featuring higher resolution ch
 */
  String getTime(int miliSeconds) {
    //print('$miliSeconds');
    var dt = DateTime.fromMillisecondsSinceEpoch(miliSeconds * 1000);

    var date = DateFormat('MM/dd/yyyy ').format(dt);
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(
            Icons.arrow_circle_left,
            size: 40,
          ),
        ),
      ), */
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage('https:${game[0].cover?.url}'),
                //fit: BoxFit.fill
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    child: IconButton(
                      color: Colors.black,
                      onPressed: () {
                        context.go('/');
                      },
                      icon: const Icon(
                        Icons.arrow_circle_left,
                        size: 60,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              margin: const EdgeInsets.only(top: 350),
              child: ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0, -4),
                            blurRadius: 8,
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${game[0].name}",
                                  style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Colors.black), //googleFonts.ptSans(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Release Date : ${getTime(game[0].firstReleaseDate!)}'),
                              Text(
                                'Rating : ${game[0].rating?.floor()}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  context.go('/comments/');
                                },
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 10)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                child: const Text(
                                  'want',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                // ignore: sort_child_properties_last
                                child: const Text(
                                  'want',
                                  style: TextStyle(fontSize: 30),
                                ),
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 10)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                              ),
                            ],
                          ),
                        ),
                        MyContainer(
                          text:
                              '${game[0].involvedCompanies?[0].company?.name}',
                          hintText: 'Developer',
                          horizontalPadding: 25,
                          verticalPadding: 5,
                          leadingIcon: const Icon(Icons.developer_board),
                          trailingIcon: const Icon(Icons.arrow_forward),
                          onTap: () {},
                        ),
                        MyContainer(
                          text: 'Similar Games',
                          horizontalPadding: 25,
                          verticalPadding: 5,
                          leadingIcon: const Icon(Icons.publish),
                          trailingIcon: const Icon(Icons.arrow_forward),
                          onTap: () {
                            context.go(
                                '/similarGames/${int.parse(widget.gameId)}');
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
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: Text(
                            'Genres',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          child: Visibility(
                            visible: isLoaded,
                            replacement: const Center(
                                child: CircularProgressIndicator()),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: game[0].genres?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.grey.withOpacity(0.4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      child: Text(
                                          '${game[0].genres?[index].name}'),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: Text(
                            'Themes',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          child: Visibility(
                            visible: isLoaded,
                            replacement: const Center(
                                child: CircularProgressIndicator()),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: game[0].themes?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.grey.withOpacity(0.4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      child: Text(
                                          ' ${game[0].themes?[index].name}'),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Videos',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        /*  YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                        ), */
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Screenshots',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 200,
                    child: Visibility(
                      visible: isLoaded,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ListView.builder(
                        itemCount: game[0].screenshots?.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https:${game[0].screenshots?[index].url}'),
                                    fit: BoxFit.fill),
                              ),
                              width: 200,
                              height: 150,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Summary',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: Text(
                        '${game[0].summary} ',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ], //children
              ),
            )
          ],
        ),
      ),
    );
  }
}


/* _videoplayercontroller =
        VideoPlayerController.network('https://youtu.be/ka4KN2KEGmI.mp4');
    _videoplayercontroller!.initialize().then((_) {
      _chewieController =
          ChewieController(videoPlayerController: _videoplayercontroller!);
      print("video player is goood");
    }); */




    //inside the build widget
    /* VideoPlayerController? _videoplayercontroller;
  ChewieController? _chewieController; */