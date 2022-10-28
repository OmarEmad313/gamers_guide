import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_2/gameDetails.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class myHomePage extends StatefulWidget {
  const myHomePage({Key? key}) : super(key: key);

  @override
  State<myHomePage> createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> {
  int selectedIndex = 0;
  final screens = [
    Center(child: Text('home', style: TextStyle(fontSize: 50))),
    //Center(child: Text('likes', style: TextStyle(fontSize: 50))),
    GameDetails(),
    Center(child: Text('search', style: TextStyle(fontSize: 50))),
    Center(child: Text('profile', style: TextStyle(fontSize: 50))),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: GNav(
          /* haptic: true, // haptic feedback
          tabActiveBorder: Border.all(
              color: Colors.blueAccent, width: 2), // tab button border
          tabBorder:
              Border.all(color: Colors.grey, width: 1), // tab button border
          tabShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
          ], // tab button shadow
          ------------------------ */
          onTabChange: (index) => setState(() => selectedIndex = index),
          /* onTabChange: (index) => setState(() {
                selectedIndex = index;
                print(selectedIndex);
              }), */
          //selectedIndex: 2,
          rippleColor:
              Colors.grey.shade800, // tab button ripple color when pressed
          tabBorderRadius: 10,
          curve: Curves.easeInOut, //animation when an icon is clicked
          gap: 6, // the tab button gap between icon and text
          color: Colors.lightBlue[800], // unselected icon color
          activeColor: Colors.white, // selected icon and text color
          iconSize: 30,
          // tab button icon size
          tabBackgroundColor: const Color.fromARGB(255, 45, 133, 233)
              .withOpacity(0.5), // selected tab background color

          padding: const EdgeInsets.symmetric(
              horizontal: 15, vertical: 10), // navigation bar padding
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.heart,
              text: 'Likes',
            ),
            GButton(
              icon: LineIcons.search,
              text: 'Search',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Profile',
            )
          ]),
    );
  }
}
