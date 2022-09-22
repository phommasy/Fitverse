import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitverse/components/config.dart';
import 'package:fitverse/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              titleSpacing: 0,
              title: Text(
                "  Fitverse",
                style: TextStyle(fontSize: 20),
              ),
              // title: Image(
              //   image: AssetImage(Config.logo),
              //   height: 19,
              // ),
              elevation: 1,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    AntDesign.search1,
                    size: 22,
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  auth.currentUser.email,
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
