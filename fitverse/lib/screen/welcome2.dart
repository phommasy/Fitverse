import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:fitverse/components/cached_image.dart';
import 'package:fitverse/components/emptypagesearch.dart';
import 'package:fitverse/components/featuredwidgets.dart';
import 'package:fitverse/components/loading_cards.dart';
import 'package:fitverse/components/nextpagesapp.dart';
import 'package:fitverse/model/category.dart';
import 'package:fitverse/screen/categorybasecontent.dart';
import 'package:fitverse/screen/searchscreen.dart';
import 'package:fitverse/tabandbloc/category_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class WelcomeScreen2 extends StatefulWidget {
  WelcomeScreen2({Key key}) : super(key: key);

  @override
  _WelcomeScreen2State createState() => _WelcomeScreen2State();
}

class _WelcomeScreen2State extends State<WelcomeScreen2>
    with AutomaticKeepAliveClientMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0)).then((value) {
      controller = new ScrollController()..addListener(_scrollListener);
      context.read<CategoryShowBloc>().getData(mounted);
    });
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final db = context.read<CategoryShowBloc>();

    if (!db.isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        context.read<CategoryShowBloc>().setLoading(true);
        context.read<CategoryShowBloc>().getData(mounted);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics().logEvent(name: 'conversion1', parameters: null);
    super.build(context);
    final cb = context.watch<CategoryShowBloc>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text('Fitverse'),
        elevation: 0,
        // actions: <Widget>[
        //   // IconButton(
        //   //   icon: Icon(
        //   //     AntDesign.search1,
        //   //     size: 22,
        //   //   ),
        //   //   onPressed: () {
        //   //     nextScreenAllApp(context, SearchScreenPage());
        //   //   },
        //   // )
        // ],
      ),
      body: RefreshIndicator(
        child: cb.hasData == false
            ? ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  EmptySearchPage(
                      icon: Feather.clipboard,
                      message: 'No categories found',
                      message1: ''),
                ],
              )
            : ListView.separated(
                controller: controller,
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                itemCount: cb.data.length != 0 ? cb.data.length + 1 : 10,
                itemBuilder: (_, int index) {
                  if (index < cb.data.length) {
                    return _ItemList(d: cb.data[index]);
                  }
                  return Opacity(
                    opacity: cb.isLoading ? 1.0 : 0.0,
                    child: cb.lastVisible == null
                        ? LoadingCard(height: null)
                        : Center(
                            child: SizedBox(
                                width: 32.0,
                                height: 32.0,
                                child: new CupertinoActivityIndicator()),
                          ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
        onRefresh: () async {
          context.read<CategoryShowBloc>().onRefresh(mounted);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ItemList extends StatelessWidget {
  final CategoryModel d;
  const _ItemList({Key key, this.d}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          height: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 10,
                    offset: Offset(0, 3),
                    color: Theme.of(context).shadowColor)
              ]),
          child: Stack(
            children: [
              Hero(
                tag: 'category${d.cat_date}',
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  child: CustomCacheImage(imageUrl: d.cat_pic, radius: 5.0),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 15, bottom: 15, right: 10),
                  child: Text(
                    d.cat_name,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.6),
                  ),
                ),
              )
            ],
          )),
      onTap: () {
        nextScreenAllApp(
            context,
            CategoryBaseOnContent(
              category: d.cat_name,
              categoryPic: d.cat_pic,
              tag: 'category${d.cat_date}',
            ));
      },
    );
  }
}
