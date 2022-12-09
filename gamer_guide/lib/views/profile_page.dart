import 'package:flutter/material.dart';

import 'package:flutter_application_2/widgets/my_container.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';

import '../widgets/sliver_app_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> texts = [
    'Favorite Games',
    'Your lists',
    'your Comments',
    'About Us'
  ];

  final List icons = <IconData>[
    //Icons.perm_device_information_outlined,
    Icons.favorite,
    Icons.list_alt_sharp,
    Icons.comment_rounded,
    Icons.accessibility_new_outlined,
  ];
  List<VoidCallback> functions = [() {}, () {}, () {}, () {}];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            MySliverAppbar(text: 'Profile', ontap: () {}),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) {
                return const SizedBox(
                  height: 70,
                );
              },
            )),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return MyContainer(
                text: texts[index],
                hintText: index == 0 ? 'Wishlist' : null,
                horizontalPadding: 30,
                verticalPadding: 5,
                size: 20,
                onTap: functions[index],
                leadingIcon: Icon(
                  icons[index],
                  color: Colors.lightBlue,
                ),
              );
            }, childCount: 4)),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) {
                return const Center(child: Text('Button'));
              },
            ))
          ],
        ),
        floatingActionButton: SpeedDial(
          overlayColor: Colors.black,
          overlayOpacity: 0.6,
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
              child: const Icon(
                Icons.perm_device_information_outlined,
              ),
              label: 'Edit profile',
              onTap: () {
                context.go('/editProfile/');
              },
            ),
            SpeedDialChild(
                child: const Icon(
                  Icons.dark_mode_outlined,
                ),
                label: 'Switch theme',
                onTap: () {}),
          ],
        ));
  }
}
/* backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.settings), */