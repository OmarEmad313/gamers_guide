import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import '../models/comments_records_model.dart';
import '../services/user_comments_services.dart';
import '../services/user_games_services.dart';
import '../widgets/my_text.dart';
import '../widgets/sliver_app_bar.dart';

class YourComments extends StatefulWidget {
  final String userId;
  const YourComments({super.key, required this.userId});

  @override
  State<YourComments> createState() => _YourCommentsState();
}

class _YourCommentsState extends State<YourComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppbar(
            text: 'Your Comments',
            ontap: () {
              context.go('/home/1');
            },
            noBack: false,
          ),
        ],
        body: StreamBuilder<List<CommentsRecordsModel>>(
          stream: fetchUserComments(widget.userId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('error');
              print(snapshot.error);
            }
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final comments = snapshot.data;
              //print(comments!.length);
              // print(userId[0]);
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: comments!.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              spacing: 10,
                              label: 'Delete',
                              icon: (Icons.delete),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              backgroundColor: Colors.red,
                              onPressed: (context) {
                                deleteComment(gameId: comments[index].gameId);
                              },
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: Colors.grey.withOpacity(0.4),
                            ),
                            height: MediaQuery.of(context).size.height * 0.275,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GetGameName(
                                    gameId: '${comments[index].gameId}'),
                                RatingBar.builder(
                                  initialRating: comments[index].starsNumber,
                                  allowHalfRating: true,
                                  ignoreGestures: true,
                                  itemSize: 20,
                                  itemBuilder: (context, index) {
                                    return const Icon(Icons.star,
                                        color: Colors.amber);
                                  },
                                  onRatingUpdate: (value) {},
                                ),
                                const MyText(
                                  text: 'Comment :',
                                  size: 15,
                                  paddingSize: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    color: Colors.white.withOpacity(0.4),
                                  ),
                                  child: MyText(
                                    text: comments[index].commentDescription,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return const Center(
                  child: MyText(
                text: 'No Comments',
                size: 30,
                weight: FontWeight.bold,
              ));
            }
          },
        ),
      ),
    );
  }
}
