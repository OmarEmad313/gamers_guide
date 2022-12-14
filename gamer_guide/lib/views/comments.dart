import 'package:flutter/material.dart';

import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_application_2/widgets/sliver_app_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import '../widgets/comments_dialog.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  var isloaded = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isloaded,
      replacement: const Center(child: CircularProgressIndicator()),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            MySliverAppbar(
              text: 'Comments on \n game name',
              ontap: () {
                context.go('/home/0');
              },
              noBack: false,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MyText(
                            text: 'username',
                            weight: FontWeight.bold,
                            size: 16,
                            paddingSize: 8,
                          ),
                          RatingBar.builder(
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
                            size: 10,
                            paddingSize: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 94,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: Colors.white.withOpacity(0.4),
                            ),
                            child: MyText(
                              text:
                                  'long texttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttasdasfsg',
                              paddingSize: 0,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                childCount: 4,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showcommentdialog(context);
          },
          backgroundColor: Colors.lightBlue,
          child: const Icon(
            Icons.comment,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
