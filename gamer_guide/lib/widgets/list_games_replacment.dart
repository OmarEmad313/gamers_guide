import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:go_router/go_router.dart';

import '../services/user_services.dart';
import 'sliver_app_bar.dart';

class ListGamesReplacment extends StatefulWidget {
  const ListGamesReplacment({
    super.key,
  });

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
          ontap: () => context.go('/yourLists/${userId[0]}'),
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
