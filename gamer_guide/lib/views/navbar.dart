import 'package:flutter/material.dart';
import 'package:flutter_application_2/views/profile_page.dart';

import 'package:flutter_application_2/views/search.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'homepage.dart';

class Navbar extends StatefulWidget {
  final String? id;
  const Navbar({Key? key, this.id}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int index() {
    int index = 0;
    widget.id == '0' ? index = 0 : index = 2;
    //print('init index $index');
    return index;
  }

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageIndex = index();
  }

  final screens = [const HomePageWidget(), const Search(), const ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[pageIndex],
      bottomNavigationBar: GNav(
          onTabChange: (index) {
            setState(() {
              pageIndex = index;
              //print('selected index = $pageIndex');
            });
          },
          selectedIndex: pageIndex,
          rippleColor:
              Colors.grey.shade800, // tab button ripple color when pressed
          tabBorderRadius: 10,
          curve: Curves.easeInOut, //animation when an icon is clicked
          gap: 6, // the tab button gap between icon and text
          color: Colors.deepPurple, // unselected icon color
          activeColor: Colors.white, // selected icon and text color
          iconSize: 30,
          // tab button icon size
          tabBackgroundColor: Colors.deepPurple
              .withOpacity(0.5), // selected tab background color

          padding: const EdgeInsets.symmetric(
              horizontal: 15, vertical: 10), // navigation bar padding
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
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
