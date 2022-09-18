import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fitverse/screen/bookmarkpage.dart';
import 'package:fitverse/screen/profilepage.dart';
import 'package:fitverse/screen/searchpage.dart';
import 'package:fitverse/screen/welcome.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  final screens = [
    WelcomeScreen(),
    SearchScreen(),
    BookmarkScreen(),
    ProfilepageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30),
      Icon(Icons.search, size: 30),
      Icon(Icons.bookmark, size: 30),
      Icon(Icons.person, size: 30),
    ];
    return Container(
      color: Color.fromARGB(255, 205, 208, 209),
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            body: screens[index],
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                iconTheme: IconThemeData(color: Color.fromARGB(255, 3, 3, 3)),
              ),
              child: CurvedNavigationBar(
                key: navigationKey,
                color: Color.fromARGB(255, 205, 208, 209),
                buttonBackgroundColor: Color.fromARGB(255, 241, 86, 24),
                backgroundColor: Colors.transparent,
                height: 60,
                animationCurve: Curves.easeInOut,
                animationDuration: Duration(milliseconds: 500),
                index: index,
                items: items,
                onTap: (index) => setState(() => this.index = index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
