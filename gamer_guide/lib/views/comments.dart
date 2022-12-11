import 'package:flutter/material.dart';

import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_application_2/widgets/sliver_app_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  var isloaded = true;

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    void show_Dialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const MyText(text: 'ADD A COMMENT', paddingSize: 0),
            //titleTextStyle: TextStyle(backgroundColor: Colors.lightBlue),
            content: SizedBox(
              height: 350,
              child: Column(
                children: [
                  const MyText(
                    text: 'Please leave a star rating',
                    paddingSize: 8,
                    weight: FontWeight.bold,
                  ),
                  RatingBar.builder(
                    glow: true,
                    glowColor: Colors.lightBlue,
                    glowRadius: 2,
                    minRating: 0.5,
                    allowHalfRating: true,
                    itemBuilder: (context, index) {
                      return const Icon(Icons.star, color: Colors.amber);
                    },
                    onRatingUpdate: (value) {
                      print('$value');
                    },
                  ),
                  const SizedBox(height: 50),
                  const MyText(
                      text: 'Your Comment :',
                      paddingSize: 8,
                      weight: FontWeight.bold),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0XFFD3D3D3),
                      hintText: 'Comment',
                      hintStyle: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const MyText(
                          text: 'Submit',
                          paddingSize: 0,
                          weight: FontWeight.bold,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Visibility(
      visible: isloaded,
      replacement: const Center(child: CircularProgressIndicator()),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            MySliverAppbar(
              text: 'Comments on \n game name',
              ontap: () {
                context.go('/');
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
                            height: 95,
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
            show_Dialog();
          },
          backgroundColor: Colors.lightBlue,
          child: const Icon(Icons.comment),
        ),
      ),
    );
  }
}
