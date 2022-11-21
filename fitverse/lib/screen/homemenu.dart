import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:fitverse/screen/bookmarkpage.dart';
import 'package:fitverse/screen/categorypage2.dart';
import 'package:fitverse/screen/profilepage.dart';
import 'package:fitverse/screen/categorypage.dart';
import 'package:fitverse/screen/welcome.dart';
import 'package:fitverse/screen/welcome2.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RemoteConfig _remoteConfig = RemoteConfig.instance;
  Future<void> _initConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(
          seconds: 1), // a fetch will wait up to 10 seconds before timing out
      minimumFetchInterval: const Duration(
          seconds:
              0), // fetch parameters will be cached for a maximum of 1 hour
    ));

    _fetchConfig();
  }

  // Fetching, caching, and activating remote config
  void _fetchConfig() async {
    await _remoteConfig.fetchAndActivate();
  }

  @override
  void initState() {
    _initConfig();
    super.initState();
  }

  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  final screens = [
    WelcomeScreen(),
    CategoryScreen(),
    BookmarkScreen(),
    ProfilepageScreen(),
  ];

  final screens2 = [
    WelcomeScreen2(),
    CategoryScreen2(),
    BookmarkScreen(),
    ProfilepageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30),
      Icon(Icons.category, size: 30),
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
            // body: screens[index],
            // body: _remoteConfig.getString('version_code').isNotEmpty
            //     ? screens2[index]
            //     : screens[index],
            body: showmenuscreen(),
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

  showmenuscreen() {
    if (_remoteConfig.getString('version_code') == '0') {
      return screens[index];
    }
    if (_remoteConfig.getString('version_code') == '1') {
      return screens[index];
    }
    if (_remoteConfig.getString('version_code') == '2') {
      return screens2[index];
    }
  }
}
