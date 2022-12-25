// ignore_for_file: unused_field

/* import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart'; */
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/game_details_model.dart';
import 'package:flutter_application_2/services/api_services.dart';
import 'package:flutter_application_2/services/user_lists_services.dart';
import 'package:flutter_application_2/widgets/horizantal_listview.dart';
import 'package:flutter_application_2/widgets/my_button.dart';
import 'package:flutter_application_2/widgets/my_container.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/list_records_model.dart';
import '../widgets/show_buttons_dialog.dart';

class GameDetails extends StatefulWidget {
  final String gameId;
  const GameDetails({Key? key, required this.gameId}) : super(key: key);

  @override
  State<GameDetails> createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails> {
  List<GameDetailsModel> game = [];
  List<ListsRecordsModel> userLists = [];
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
    //userLists = await fetchListsRecords();
    if (game.isNotEmpty) {
      setState(() {
        isLoaded = true;
      });
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
                          child: Expanded(
                            child: MyText(
                              text: '${game[0].name}',
                              paddingSize: 0,
                              size: 36,
                              weight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text:
                                    'Release Date : ${getTime(game[0].firstReleaseDate!)}',
                                color: Colors.black,
                              ),
                              MyText(
                                text: 'Rating : ${game[0].rating?.floor()}',
                                color: Colors.black,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MyButton(
                                text: 'Comments',
                                onPressed: (() => context.go(
                                    '/comments/${int.parse(widget.gameId)}/${game[0].name}')),
                                size: 30,
                              ),
                              MyButton(
                                text: 'Add',
                                onPressed: () =>
                                    showButtons(context, userLists),
                                size: 30,
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
                          onTap: () {},
                        ),
                        MyContainer(
                          text: 'Similar Games',
                          horizontalPadding: 25,
                          verticalPadding: 5,
                          leadingIcon: const Icon(Icons.publish),
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
                        const MyText(
                            text: 'Videos',
                            paddingSize: 20,
                            size: 20,
                            weight: FontWeight.bold),

                        /*  YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                        ), */
                        const MyText(
                            text: 'Screenshots',
                            paddingSize: 20,
                            size: 20,
                            weight: FontWeight.bold),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
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
                  const MyText(
                      text: 'Summary',
                      paddingSize: 20,
                      size: 20,
                      weight: FontWeight.bold),
                  MyText(
                    text: '${game[0].summary}',
                    paddingSize: 20,
                    size: 15,
                    color: Colors.black.withOpacity(0.5),
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