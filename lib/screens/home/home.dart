import 'package:flutter/material.dart';
import 'package:mm/screens/home/profile_screen.dart';
import 'package:mm/screens/home/search_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../theme/app_colors.dart';
import 'explore_screen.dart';
import 'home_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  final List<Widget> _screens = [
    HomeWidget(),
    SearchWidget(),
    ExploreWidget(),
    ProfileWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.black,
      bottomNavigationBar: SalomonBottomBar(
        itemPadding: EdgeInsets.all(8),
        margin: EdgeInsets.all(12),
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        selectedItemColor: appColors.yellow,
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home, size: 28),
            title: Text("Home"),
            selectedColor: appColors.yellow,
            unselectedColor: appColors.white,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.search, size: 28),
            title: Text("Search"),
            selectedColor: appColors.yellow,
            unselectedColor: appColors.white,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.explore, size: 28),
            title: Text("Explore"),
            selectedColor: appColors.yellow,
            unselectedColor: appColors.white,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person, size: 28),
            title: Text("Profile"),
            selectedColor: appColors.yellow,
            unselectedColor: appColors.white,
          ),
        ],
      ),
      body: _screens[_selectedTab],
    );
  }
}