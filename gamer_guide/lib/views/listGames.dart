import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/user_services.dart';

import 'package:go_router/go_router.dart';

import '../models/popular_games.dart';
import '../services/api_services.dart';
import '../services/user_lists_services.dart';
import '../widgets/list_games_replacment.dart';
import '../widgets/sliver_app_bar.dart';

class ListGames extends StatefulWidget {
  final String listName;
  const ListGames({super.key, required this.listName});

  @override
  State<ListGames> createState() => _ListGamesState();
}

class _ListGamesState extends State<ListGames> {
  List<String> userListGamesIds = [];
  List<GamesCoverModel> gamecovers = [];
  List tempList = [];
  bool isloaded = false;
  String myUserid = '';
  @override
  void initState() {
    mainFunction();
    super.initState();
  }

  Future<void> mainFunction() async {
    myUserid = await getUserId();
    userListGamesIds =
        await UserListsServices.getUserListGamesIds(widget.listName);

    for (var i = 0; i < userListGamesIds.length; i++) {
      gamecovers =
          await GameServices.getGameCovers(int.parse(userListGamesIds[i]));
      tempList.add(gamecovers[0].cover?.url);
    }
    //print(tempList[0]);
    if (tempList.isNotEmpty && myUserid.isNotEmpty) {
      setState(() {
        isloaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isloaded,
      replacement: ListGamesReplacment(userid: myUserid),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MySliverAppbar(
              text: 'Games in\n${widget.listName}',
              ontap: () => context.go('/yourLists/$myUserid'),
              noBack: false,
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                //spaces between grids zy elpadding (horizantal)
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https:${tempList[index]}'), //url[index]
                            fit: BoxFit.fill),
                      ),
                    ),
                  );
                },
                childCount: tempList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
