import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_2/widgets/my_button.dart';

import 'package:flutter_application_2/widgets/my_container.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';

import '../services/user_services.dart';
import '../widgets/sliver_app_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String myuserid = '';
  String userName = '';

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
    userdata();
  }

  Future userdata() async {
    myuserid = await getUserId();
    userName = await getUserName();

    if (myuserid.isNotEmpty && userName.isNotEmpty) {
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
              SliverToBoxAdapter(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1)),
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
                      context.go('/favoriteGames/$myuserid');
                    }
                    if (index == 1) {
                      context.go('/yourLists/$myuserid');
                    }
                    if (index == 2) {
                      context.go('/yourComments/$myuserid');
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
                  context.go('/editProfile/$userName/$myuserid');
                },
              ),
              SpeedDialChild(
                  child: const Icon(
                    Icons.privacy_tip_outlined,
                  ),
                  label: 'Privacy and Policy',
                  onTap: () {}),
              SpeedDialChild(
                  child: const Icon(
                    Icons.help,
                  ),
                  label: 'Tutorial',
                  onTap: () {
                    context.go('/parentIntro'); /* parentIntro */
                  }),
            ],
          )),
    );
  }
}
