import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitverse/components/config.dart';
import 'package:fitverse/components/nextpagesapp.dart';
import 'package:fitverse/screen/login.dart';
import 'package:fitverse/screen/searchscreen.dart';
import 'package:fitverse/tabandbloc/featured_bloc.dart';
import 'package:fitverse/tabandbloc/recent_contentsbloc.dart';
import 'package:fitverse/tabandbloc/taballHome.dart';
import 'package:fitverse/tabandbloc/taballHome2.dart';
import 'package:fitverse/tapandbloc/tabindexhomebloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class CategoryScreen2 extends StatefulWidget {
  CategoryScreen2({Key key}) : super(key: key);
  @override
  _CategoryScreen2State createState() => _CategoryScreen2State();
}

class _CategoryScreen2State extends State<CategoryScreen2>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<Tab> _tabs = [
    Tab(
      text: "Explore",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      context.read<TabIndexBlocHome>().setTabIndexHome(_tabController.index);
    });
    Future.delayed(Duration(milliseconds: 0)).then((value) {
      context.read<FeaturedBloc>().getData();
      context.read<RecentBloc>().getData(mounted);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
              "  Wellness centers list",
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
                onPressed: () {
                  nextScreenAllApp(context, SearchScreenPage());
                },
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ];
      }, body: Builder(
        builder: (BuildContext context) {
          final innerScrollController = PrimaryScrollController.of(context);
          return TabMediumTwo(
            sc: innerScrollController,
            tc: _tabController,
          );
        },
      )),
    );
  }
}
