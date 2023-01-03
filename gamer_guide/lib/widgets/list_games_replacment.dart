import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:go_router/go_router.dart';

import '../services/user_services.dart';
import 'sliver_app_bar.dart';

class ListGamesReplacment extends StatefulWidget {
  final String userid;
  const ListGamesReplacment({super.key, required this.userid});

  @override
  State<ListGamesReplacment> createState() => _ListGamesReplacmentState();
}

class _ListGamesReplacmentState extends State<ListGamesReplacment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        MySliverAppbar(
          text: 'Loading',
          ontap: () => context.go('/yourLists/${widget.userid}'),
          noBack: false,
        ),
        const SliverToBoxAdapter(
          child: Center(
            heightFactor: 15,
            child: MyText(
              text: 'No Games In This List',
              size: 30,
              weight: FontWeight.bold,
            ),
          ),
        )
      ]),
    );
  }
}
