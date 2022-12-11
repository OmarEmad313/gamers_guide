import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import '../widgets/my_text.dart';
import '../widgets/sliver_app_bar.dart';

class YourComments extends StatefulWidget {
  const YourComments({super.key});

  @override
  State<YourComments> createState() => _YourCommentsState();
}

class _YourCommentsState extends State<YourComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        MySliverAppbar(
          text: 'Your Comments',
          ontap: () {
            context.go('/profile');
          },
          noBack: false,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 4,
            (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyText(
                        text: 'Game Name',
                        weight: FontWeight.bold,
                        size: 16,
                        paddingSize: 8,
                      ),
                      RatingBar.builder(
                        ignoreGestures: true,
                        itemSize: 20,
                        itemBuilder: (context, index) {
                          return const Icon(Icons.star, color: Colors.amber);
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
          ),
        )
      ]),
    );
  }
}
