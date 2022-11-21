import 'package:fitverse/components/featuredwidgets.dart';
import 'package:fitverse/components/recent_contentshome.dart';
import 'package:fitverse/tabandbloc/featured_bloc.dart';
import 'package:fitverse/tabandbloc/recent_contentsbloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab02 extends StatefulWidget {
  Tab02({Key key}) : super(key: key);

  @override
  _Tab02State createState() => _Tab02State();
}

class _Tab02State extends State<Tab02> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FeaturedBloc>().onRefresh();
        context.read<RecentBloc>().onRefresh(mounted);
      },
      child: SingleChildScrollView(
        key: PageStorageKey('key0'),
        padding: EdgeInsets.all(0),
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [Featured(), RecentContents()],
        ),
      ),
    );
  }
}
