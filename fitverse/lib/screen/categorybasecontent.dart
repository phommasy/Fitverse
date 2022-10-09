import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitverse/card/cardforcategory.dart';
import 'package:fitverse/card/cardforcategory2.dart';
import 'package:fitverse/components/cached_image.dart';
import 'package:fitverse/components/emptypagesearch.dart';
import 'package:fitverse/components/loading_cards.dart';
import 'package:fitverse/model/contents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CategoryBaseOnContent extends StatefulWidget {
  final String category;
  final String categoryPic;
  final String tag;
  CategoryBaseOnContent({Key key, this.category, this.categoryPic, this.tag})
      : super(key: key);

  @override
  _CategoryBaseOnContentState createState() => _CategoryBaseOnContentState();
}

class _CategoryBaseOnContentState extends State<CategoryBaseOnContent> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String collectionName = 'contents';
  ScrollController controller;
  DocumentSnapshot _lastVisible;
  bool _isLoading;
  List<DocumentSnapshot> _snap = [];
  List<Article> _data = [];
  bool _hasData;

  @override
  void initState() {
    controller = new ScrollController()..addListener(_scrollListenercat);
    super.initState();
    _isLoading = true;
    _getData();
  }

  onRefresh() {
    setState(() {
      _snap.clear();
      _data.clear();
      _isLoading = true;
      _lastVisible = null;
    });
    _getData();
  }

  Future<Null> _getData() async {
    setState(() => _hasData = true);
    QuerySnapshot data;
    if (_lastVisible == null)
      data = await firestore
          .collection(collectionName)
          .where('category', isEqualTo: widget.category)
          .orderBy('cid', descending: true)
          .limit(8)
          .get();
    else
      data = await firestore
          .collection(collectionName)
          .where('category', isEqualTo: widget.category)
          .orderBy('cid', descending: true)
          .startAfter([_lastVisible['cid']])
          .limit(8)
          .get();
    if (data.docs.length > 0) {
      _lastVisible = data.docs[data.docs.length - 1];
      if (mounted) {
        setState(() {
          _isLoading = false;
          _snap.addAll(data.docs);
          _data = _snap.map((e) => Article.fromFirestore(e)).toList();
        });
      }
    } else {
      if (_lastVisible == null) {
        setState(() {
          _isLoading = false;
          _hasData = false;
          print('no items');
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasData = true;
          print('no more items');
        });
      }
    }
    return null;
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListenercat);
    super.dispose();
  }

  void _scrollListenercat() {
    if (!_isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        setState(() => _isLoading = true);
        _getData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: CustomScrollView(
          controller: controller,
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: Color.fromARGB(255, 250, 61, 3),
                  ),
                )
              ],
              backgroundColor: Colors.orange[300],
              expandedHeight: MediaQuery.of(context).size.height * 0.20,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                background: Hero(
                  tag: widget.tag,
                  child: CustomCacheImage(
                      imageUrl: widget.categoryPic, radius: 0.0),
                ),
                title: Text(
                  widget.category,
                ),
                titlePadding: EdgeInsets.only(left: 20, bottom: 15, right: 20),
              ),
            ),
            _hasData == false
                ? SliverFillRemaining(
                    child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.30,
                      ),
                      EmptySearchPage(
                          icon: Feather.clipboard,
                          message: 'No articles found',
                          message1: ''),
                    ],
                  ))
                : SliverPadding(
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index < _data.length) {
                            if (index % 2 == 0 && index != 0)
                              return CategoryBaseArticleCard2(
                                d: _data[index],
                                heroTag: 'categorybased$index',
                              );
                            return CategoryBaseArticleCard(
                              d: _data[index],
                              heroTag: 'categorybased$index',
                            );
                          }
                          return Opacity(
                            opacity: _isLoading ? 1.0 : 0.0,
                            child: _lastVisible == null
                                ? Column(
                                    children: [
                                      LoadingCard(
                                        height: 200,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      )
                                    ],
                                  )
                                : Center(
                                    child: SizedBox(
                                        width: 32.0,
                                        height: 32.0,
                                        child:
                                            new CupertinoActivityIndicator()),
                                  ),
                          );
                        },
                        childCount: _data.length == 0 ? 5 : _data.length + 1,
                      ),
                    ),
                  ),
          ],
        ),
        onRefresh: () async => onRefresh(),
      ),
    );
  }
}
