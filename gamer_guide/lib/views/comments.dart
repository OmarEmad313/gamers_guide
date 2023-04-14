import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/user_services.dart';

import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_application_2/widgets/sliver_app_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import '../models/comments_records_model.dart';
import '../services/user_comments_services.dart';
import '../widgets/comments_dialog.dart';

class Comments extends StatefulWidget {
  final String gameId;
  final String gameName;
  const Comments({super.key, required this.gameId, required this.gameName});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  var isloaded = false;
  List<CommentsRecordsModel> comments = [];
  // String userName = '';

  @override
  void initState() {
    // initComments();

    super.initState();
  }

  /*  void initComments() async {
    comments = await fetchGameComments(widget.gameId);
    if (comments.isNotEmpty) {
      setState(() {
        isloaded = true;
        //print('Users id are ${comments[1].userId}');
      });
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          MySliverAppbar(
            text: 'Comments on \n${widget.gameName}',
            ontap: () {
              //context.go('/gamedetails/${int.parse(widget.gameId)}');
              Navigator.pop(context);
            },
            noBack: false,
          ),
          SliverToBoxAdapter(
            child: StreamBuilder<List<CommentsRecordsModel>>(
              stream: fetchGameComments(widget.gameId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('error');
                }
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final comments = snapshot.data;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: comments!.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: Colors.grey.withOpacity(0.4),
                              ),
                              height:
                                  MediaQuery.of(context).size.height * 0.275,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GetUsersNames(
                                      userId: comments[index]
                                          .userId), // comments[index].userId
                                  RatingBar.builder(
                                    initialRating: comments[index].starsNumber,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                    child: MyText(
                                      text: comments[index]
                                                  .commentDescription ==
                                              ''
                                          ? 'No Comment'
                                          : comments[index].commentDescription,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
                  );
                } else {
                  return const Center(
                    heightFactor: 18,
                    child: MyText(
                        text: "No Comments For This Game",
                        size: 25,
                        weight: FontWeight.bold),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showcommentdialog(context, widget.gameId);
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.comment,
          color: Colors.white,
        ),
      ),
    );
  }
}
