import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/provider/theme_provider.dart';
import 'package:flutter_application_2/widgets/my_button.dart';

import 'package:flutter_application_2/widgets/my_container.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../services/user_services.dart';
import '../widgets/sliver_app_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isloaded = false;
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
  @override
  void initState() {
    super.initState();
    userid();
  }

  Future userid() async {
    await getUserId();
    if (userId.isNotEmpty) {
      //print(userId[0]);
      setState(() => isloaded = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isloaded,
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
      child: Scaffold(
          body: CustomScrollView(
            slivers: [
              MySliverAppbar(
                text: 'Profile',
                ontap: () {},
                noBack: true,
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 60)),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return MyContainer(
                  text: texts[index],
                  hintText: index == 0 ? 'Wishlist' : null,
                  horizontalPadding: 30,
                  verticalPadding: 5,
                  size: 20,
                  onTap: () {
                    if (index == 0) {
                      context.go('/favoriteGames/${userId[0]}');
                    }
                    if (index == 1) {
                      context.go('/yourLists/${userId[0]}');
                    }
                    if (index == 2) {
                      context.go('/yourComments/');
                    }
                  },
                  leadingIcon: Icon(
                    icons[index],
                    color: Colors.deepPurple,
                  ),
                );
              }, childCount: 4)),
              SliverToBoxAdapter(
                  child: Center(
                      child: MyButton(
                color: Colors.red,
                text: 'Sign Out',
                onPressed: () {
                  context.go('/');
                  FirebaseAuth.instance.signOut();
                },
              ))),
            ],
          ),
          floatingActionButton: SpeedDial(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
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
          )),
    );
  }
}
/* backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.settings), */