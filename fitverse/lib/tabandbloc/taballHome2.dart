import 'package:fitverse/tabandbloc/recent_contentsbloc.dart';
import 'package:fitverse/tabandbloc/tab0.dart';
import 'package:fitverse/tabandbloc/tab02.dart';
import 'package:fitverse/tabandbloc/tabindexhomebloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabMediumTwo extends StatefulWidget {
  final ScrollController sc;
  final TabController tc;
  TabMediumTwo({Key key, this.sc, this.tc}) : super(key: key);

  @override
  _TabMediumTwoState createState() => _TabMediumTwoState();
}

class _TabMediumTwoState extends State<TabMediumTwo> {
  @override
  void initState() {
    super.initState();
    this.widget.sc.addListener(_scrollListener);
  }

  void _scrollListener() {
    final db = context.read<RecentBloc>();
    final sb = context.read<TabIndexBlocHome>();

    if (sb.tabIndex == 0) {
      if (!db.isLoading) {
        if (this.widget.sc.offset >= this.widget.sc.position.maxScrollExtent &&
            !this.widget.sc.position.outOfRange) {
          print("reached the bottom");
          db.setLoading(true);
          db.getData(mounted);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        Tab02(),
      ],
      controller: widget.tc,
    );
  }
}
