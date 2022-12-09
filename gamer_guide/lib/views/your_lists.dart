import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../widgets/sliver_app_bar.dart';

class YourLists extends StatefulWidget {
  const YourLists({super.key});

  @override
  State<YourLists> createState() => _YourListsState();
}

class _YourListsState extends State<YourLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MySliverAppbar(
              text: 'Your Lists',
              ontap: () {
                context.go('/profile');
              }),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 4,
            (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  height: 100,
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
